import { Request,Response,NextFunction } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function getPromotionType(req:Request,res:Response,next:NextFunction){
    try{
        const data = await prisma.promotion_Type.findMany({
            select:{
                promotion_type_id:true,
                promotion_type:true
            },
            orderBy: {
                promotion_type_id : 'asc'
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

export {getPromotionType};