import { Request , Response , NextFunction } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function getCouponByUser(req:Request,res:Response,next:NextFunction){
    try{

        const { user } = req.query;

        const data = await prisma.coupon.findMany({
            where: {
                user_id: Number(user as string)
            },
            orderBy: {
                created_at : 'asc'
            }
        });
        res.status(200).send({
            message:"Success",
            data:data
        })
    }catch(err){
        next(err)   
    }
}

export {getCouponByUser}