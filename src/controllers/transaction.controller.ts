import { Request, Response, NextFunction } from "express";
import { PrismaClient } from "@prisma/client";
import { cloudinaryUpload } from "../utils/cloudinary";

const prisma = new PrismaClient();

async function createTransaction(req: Request, res: Response, next: NextFunction) {
    try {
        const {
            total_price,
            discount,
            points_used,
            coupon_id,
            event_id,
            event_discount,
            event_price,
            event_quantity,
            event_ticket_id,
            payment_status_id,
            user_id
        } = req.body;

        let imageUrl = null;
        if (event_ticket_id != 1) {
            if (!req.file) throw new Error("Image is required");

            const cloudinaryResult = await cloudinaryUpload(req.file);
            imageUrl = cloudinaryResult.secure_url;
        }

        await prisma.$transaction(async (prisma) => {
            const payloadTransaction = {
                total_price: Number(total_price),
                user_id: Number(user_id),
                discount: Number(discount),
                points_used: Number(points_used),
                payment_proof: imageUrl,
                coupon_id: coupon_id ? Number(coupon_id) : null,
                payment_status_id: Number(payment_status_id),
                event_id: Number(event_id),
                discount_event: Number(event_discount),
                price: Number(event_price),
                quantity: Number(event_quantity),
                ticket_id: Number(event_ticket_id),
            };

            const responseCreateTransaction = await prisma.transaction.create({
                data: payloadTransaction,
            });

            res.status(200).send({
                message: "Success",
                data: responseCreateTransaction
            });
        });
    } catch (err) {
        next(err);
    }
}

async function getTransactionByUserId(req: Request, res: Response, next: NextFunction) {
    try {

        const { userId } = req.params;

        const data = await prisma.transaction.findMany({
            include: {
                user: true,
                event: true,
                ticket: true

            },
            where: {
                user_id: parseInt(userId),
            }
        });
        res.status(200).send(data)
    } catch (err) {
        next(err);
    }
}

async function updateTransactionReview(req: Request, res: Response, next: NextFunction) {
    try {
        const { transactionId } = req.params;

        const {
            review,
        } = req.body;

        await prisma.transaction.update({
            where: {
                id: parseInt(transactionId),
            },
            data: { review }
        });

        res.status(200).send({ message: 'update success' });
    } catch (err) {
        next(err);
    }
}

async function getTransactionByEventId(req: Request, res: Response, next: NextFunction) {
    try {

        const { eventId } = req.params;

        const data = await prisma.transaction.findMany({
            include: {
                user: true,
                event: true,
                ticket: true

            },
            where: {
                event_id: parseInt(eventId),
            }
        });
        res.status(200).send(data)
    } catch (err) {
        next(err);
    }
}

export {
    createTransaction,
    getTransactionByUserId,
    updateTransactionReview,
    getTransactionByEventId
};