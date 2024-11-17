import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { compare, genSalt, hash } from "bcrypt";
import crypto from "crypto";
import { sign } from "jsonwebtoken";
import { SECRET_KEY } from "../utils/envConfig";

const prisma = new PrismaClient();

function generateReferralCode(): string {
   return crypto.randomBytes(8).toString('hex');
}

async function checkUniqueReferralCode(referal_code: string): Promise<string> {
   let existingUser = await prisma.user.findUnique({ where: { referal_code } });

   if (existingUser) {
      return checkUniqueReferralCode(generateReferralCode());
   }

   return referal_code;
}

function generateCouponCode(): string {
   return crypto.randomBytes(6).toString('hex').toUpperCase();
}

async function Register(req: Request, res: Response, next: NextFunction) {
   try {
      const { name, email, password, role, referal_code } = req.body;

      if (!["attendee", "event organizer"].includes(role.toLowerCase())) {
         throw new Error("Invalid role");
      }

      const existingUser = await prisma.user.findFirst({
         where: { email },
      });

      if (existingUser) {
         throw new Error("Email already exists");
      }

      let referralCode = "";

      if (role.toLowerCase() === "attendee") {
         referralCode = await checkUniqueReferralCode(generateReferralCode());

         if (referal_code) {
            const referrer = await prisma.user.findUnique({
               where: { referal_code }
            });

            if (!referrer) {
               throw new Error("Invalid referral code");
            }

            const pointToAdd = 10000;
            await prisma.user_Point.create({
               data: {
                  user_id: referrer.user_id,
                  points: pointToAdd,
                  expiry_date: new Date(new Date().setMonth(new Date().getMonth() + 3)),
               },
            });

            await prisma.user.update({
               where: { user_id: referrer.user_id },
               data: { points: { increment: pointToAdd } },
            });

            const couponCode = generateCouponCode();
            await prisma.coupon.create({
               data: {
                  code: couponCode,
                  discount: 0.10,
                  max_uses: 1,
                  valid_from: new Date(),
                  valid_until: new Date(new Date().setMonth(new Date().getMonth() + 3)),
                  user_id: null,
               },
            });
         }
      }

      if (role.toLowerCase() === 'event organizer' && referal_code) {
         throw new Error('Event organizer cannot use referal code ');
      }

      const salt = await genSalt(10);
      const hashedPassword = await hash(password, salt);

      const newUser = await prisma.user.create({
         data: {
            name,
            email,
            password: hashedPassword,
            role_id: role.toLowerCase() === "attendee" ? 1 : 2,
            referal_code: referralCode,
         }
      })

      if (referal_code) {
         const coupon = await prisma.coupon.findFirst({
            where: { code: generateCouponCode(), },
         });

         if (coupon) {
            await prisma.coupon.update({
               where: { id: coupon.id },
               data: { user_id: newUser.user_id },
            })
         }
      }

      res.status(201).json({
         message: "User created successfully",
         user: {
            id: newUser.user_id,
            name: newUser.name,
            email: newUser.email,
            role,
            referal_code: referralCode,
         }
      })
   } catch (error) {
      next(error);
   }
}

async function Login(req: Request, res: Response, next: NextFunction) {
   try {
      const { email, password } = req.body;

      const existingUser = await prisma.user.findUnique({
         where: { email },
         include: { role: true },
      })

      if (!existingUser || !(await compare(password, existingUser.password))) {
         throw new Error("Invalid email or password");
      }

      const payload = {
         name: existingUser.name,
         email: existingUser.email,
         role: existingUser.role.role_name,
      }

      const token = sign(payload, SECRET_KEY as string, { expiresIn: "1h" });
      res.status(200).send({
         message: "Login successful",
         access_token: token,
      })
   } catch (error) {
      next(error);
   }
}

export { Register, Login };