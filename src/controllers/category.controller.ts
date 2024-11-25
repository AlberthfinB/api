import { Request,Response,NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

async function getAllCategory (req:Request,res:Response,next:NextFunction){
    try{
        const data =await prisma.event_Category.findMany({
            select:{
                event_category_id:true,
                event_category_name:true,
            },
            orderBy:{
                event_category_name: "asc"
            }
        });
        res.status(200).send({
            message:"Success",
            data:data
        })
    }catch(err){
        next(err)
    };
}

export {getAllCategory};