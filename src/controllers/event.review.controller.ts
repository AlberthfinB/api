import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { User } from "../custom";

const prisma = new PrismaClient();

async function createReview(req: Request, res: Response, next: NextFunction) {
    try {
        const { event_id } = req.body;

        const { email } = req.user as User
        const dataUser = await prisma.user.findUnique({
            where: { email },
        });

        if (!dataUser) throw new Error("user tidak di temukan")

        const checkStatusEvent = await prisma.event.findUnique({
            where: { event_id: Number(event_id) },
            select: { status_event_id: true }
        });

        if (!checkStatusEvent) {
            throw new Error("not an status event")
        }

        if (checkStatusEvent.status_event_id != 4) {
            throw new Error("status event an found or still ongoing")
        }

        res.status(201).send({
            message: "success",
        })
    } catch (err) {
        next(err);
    }
}

export {createReview}