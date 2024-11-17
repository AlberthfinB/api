import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { cloudinaryUpload } from "../utils/cloudinary";

const prisma = new PrismaClient();

async function createEvent(req: Request, res: Response, next: NextFunction) {
   try {
      const {
         name_event,
         location,
         description,
         ticket_price,
         promo_event,
         seats,
         status_event,
         event_expired,
         ticket_id,
         event_category_id,
      } = req.body;

      const email = req.user?.email; //tunggu data token

      const dataUser = await prisma.user.findUnique({
         where: { email },
      });

      if (!req.file) throw new Error("Image is required");

      if (status_event !== "Published" && status_event !== "Completed")
         throw new Error("invalid Status Event");

      const cloudinaryResult = await cloudinaryUpload(req.file);
      const imageUrl = cloudinaryResult.secure_url;

      let adjustedTicketPrice = Number(ticket_price);

      if (ticket_id == 2 && adjustedTicketPrice >= 1)
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
            promo_event,
            seats: Number(seats),
            status_event,
            event_expired,
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

async function getEvent(req: Request, res: Response, next: NextFunction) {
   try {
      const { event_id } = req.params;

      const dataEvent = await prisma.event.findUnique({
         where: { event_id: Number(event_id) },
         include: {
            user: true,
            ticket_type: true,
            event_category: true,
         },
      });
      res.status(200).send({
         message: "Succes Get event",
         data: dataEvent,
      });
   } catch (err) {
      next(err);
   }
}

async function getEvents(req: Request, res: Response, next: NextFunction) {
   try {
      const data = await prisma.event.findMany({});

      res.status(200).send({
         message: "Success",
         data: data,
      });
   } catch (err) {
      next(err);
   }
}
export { createEvent, getEvent, getEvents };
