import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { cloudinaryUpload } from "../utils/cloudinary";
import { User } from "../custom";

const prisma = new PrismaClient();

async function createEvent(req: Request, res: Response, next: NextFunction) {
   try {
      const {
         name_event,
         location,
         description,
         ticket_price,
         seats,
         event_expired,
         ticket_id,
         event_category_id,
         status_event_id,
         promo_event,
      } = req.body;
      
      const {email} = req.user as User

      const dataUser = await prisma.user.findUnique({
         where: { email },
      });

      if (!req.file) throw new Error("Image is required");
      const cloudinaryResult = await cloudinaryUpload(req.file);
      const imageUrl = cloudinaryResult.secure_url;

      let adjustedTicketPrice = Number(ticket_price);

      if (ticket_id == 1 && adjustedTicketPrice >= 1)
         throw new Error(
            "The ticket cannot have a price because it is marked as free"
         );

      const newEvent = await prisma.event.create({
         data: {
            name_event,
            location,
            description,
            image_event: imageUrl,
            ticket_price: adjustedTicketPrice,
            seats: Number(seats),
            promo_event,
            event_expired,
            status_event_id:Number(status_event_id),
            user_id: Number(dataUser?.user_id),
            ticket_id: Number(ticket_id),
            event_category_id: Number(event_category_id),
         },
      });
      res.status(201).send({
         message: "Create Event Success",
         newEvent,
      });
   } catch (err) {
      next(err);
   }
}

async function getEventsIncoming(
   req: Request,
   res: Response,
   next: NextFunction
) {
   try {
      const data = await prisma.event.findMany({
         where: { status_event_id: 1 },
         select: {
            name_event: true,
            location: true,
            description: true,
            ticket_price: true,
            image_event: true,
         },
      });
      res.status(200).send({
         message: "Success",
         data: data,
      });
   } catch (err) {
      next(err);
   }
}

async function getEventbyId (req:Request,res:Response,next:NextFunction) {
   try{
      const {event_id} = req.params;

      const eventByid = await prisma.event.findUnique({
         where:{
            event_id:parseInt(event_id),
         }
      });
      res.status(200).send({
         message:"get id success",
         eventByid,
      });
   }catch(err){
      next(err);
   }
}
export { createEvent ,getEventsIncoming , getEventbyId };
