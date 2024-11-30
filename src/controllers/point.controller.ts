import { Request,Response,NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { User } from "../custom";

const prisma = new PrismaClient();

async function getPointByUser(req:Request,res:Response,next:NextFunction){
    try{
        const { user } = req.query;

        const data = await prisma.user_Point.findMany({
            where: {
                user_id: parseInt(user as string)
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

export {getPointByUser};