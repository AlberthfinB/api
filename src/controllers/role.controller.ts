import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function createRole(req: Request, res: Response, next: NextFunction) {
   const { role_name } = req.body;

   try {
      const roleUser = await prisma.role.create({
         data: {
            role_name,
         },
      });
      res.status(201).send({
         msg: "succses",
         roleUser,
      });
   } catch (err) {
      next(err);
   }
}

export { createRole };
