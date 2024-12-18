import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { compare, genSalt, hash } from "bcrypt";
import crypto from "crypto";
import { sign } from "jsonwebtoken";
import { BASE_WEB_URL, SECRET_KEY } from "../utils/envConfig";
import { tranporter } from "../lib/mail";
import { User } from "../custom";
import path from "path";
import fs from "fs";
import Handlebars from "handlebars";

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
   const { name, email, password, role, referal_code } = req.body;

   const transaction = await prisma.$transaction(async (prisma) => {
      try {
         if (!["participant", "event organizer"].includes(role.toLowerCase())) {
            throw new Error("Invalid role");
         }

         const existingUser = await prisma.user.findFirst({
            where: { email },
         });

         if (existingUser) {
            throw new Error("Email already exists");
         }

         let referralCode = "";
         let referrer = null;
         let couponCode = "";

         if (role.toLowerCase() === 'event organizer' && referal_code) {
            throw new Error('Event organizer cannot use referal code ');
         }

         if (role.toLowerCase() === "participant") {
            referralCode = await checkUniqueReferralCode(generateReferralCode());

            if (referal_code) {
               referrer = await prisma.user.findUnique({
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

               couponCode = generateCouponCode();
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

         const salt = await genSalt(10);
         const hashedPassword = await hash(password, salt);

         const newUser = await prisma.user.create({
            data: {
               name,
               email,
               password: hashedPassword,
               role_id: role.toLowerCase() === "participant" ? 1 : 2,
               referal_code: role.toLowerCase() === "participant" ? referralCode : null,
            }
         })

         const payload = { email };
         const token = sign(payload, SECRET_KEY as string, { expiresIn: "1hr" });
         // console.log(`Generated token: ${token}`);
         const templatePath = path.join(__dirname, "../templates", "verification-email.hbs");
         const verificationUrl = BASE_WEB_URL + `/verify/${token}`;
         const templateSource = fs.readFileSync(templatePath, "utf-8");
         const compiledTemplate = Handlebars.compile(templateSource);
         const html = compiledTemplate({ name, verificationUrl, emailUser: email });


         await tranporter.sendMail({
            to: email,
            subject: "Verification Email",
            html,
         });

         if (referal_code && referrer) {
            await prisma.referral.create({
               data: {
                  referrer_id: referrer.user_id,
                  referee_id: newUser.user_id,
                  points: 10000,
                  expiry_date: new Date(new Date().setMonth(new Date().getMonth() + 3)),
               }
            });
         }

         if (referal_code) {
            await prisma.coupon.updateMany({
               where: { code: couponCode, user_id: null },
               data: { user_id: newUser.user_id },
            })
         }

         return newUser;

      } catch (error) {
         next(error);
      }
   });

   if (transaction) {
      res.status(201).json({
         message: "User created successfully",
         user: {
            id: transaction.user_id,
            name: transaction.name,
            email: transaction.email,
            role,
            referal_code: transaction.referal_code,
         }
      });
   } else {
      throw new Error("User creation failed");
   }
}

async function Login(req: Request, res: Response, next: NextFunction) {
   try {
      const { email, password } = req.body;

      const existingUser = await prisma.user.findUnique({
         where: { email },
         include: { role: true },
      })

      if (!existingUser?.isVerified) {
         throw new Error("Please verify your account first");
      }
      if (!existingUser || !(await compare(password, existingUser.password))) {
         throw new Error("Invalid email or password");
      }

      const payload = {
         name: existingUser.name,
         email: existingUser.email,
         role: existingUser.role.role_name,
         user_id: existingUser.user_id
      }

      const token = sign(payload, SECRET_KEY as string, { expiresIn: "5hr" });
      res.status(200).cookie("access_token", token).send({
         message: "Login successful",
         access_token: token,
      })
   } catch (error) {
      next(error);
   }
}

async function VerifyUser(req: Request, res: Response, next: NextFunction) {
   try {
      const { email } = req.user as User;
      console.log(email);
      await prisma.user.update({
         where: { email },
         data: {
            isVerified: true,
         }
      })
      res.status(200).send({
         message: "User verified successfully",
      })
   } catch (error) {
      next(error);
   }
}

async function getReferralCode(req: Request, res: Response, next: NextFunction) {
   try {
      const { email } = req.user as User;
      const user = await prisma.user.findUnique({
         where: { email },
         select: { referal_code: true },
      });

      if (!user) {
         throw new Error("User not found");
      }

      res.status(200).json({
         message: "Referral code retrieved successfully",
         data: user.referal_code,
      });
   } catch (error) {
      next(error);
   }
}

export { Register, Login, VerifyUser, getReferralCode };