import { Request,Response,NextFunction } from "express";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function getTicketType(req:Request,res:Response,next:NextFunction){
    try{
        const data = await prisma.ticket_Type.findMany({
            select:{
                ticket_id:true,
                ticket_type:true
            },
        });
        res.status(200).send({
            message:"Success",
            data:data
        })
    }catch(err){
        next(err);
    }
}

export {getTicketType}