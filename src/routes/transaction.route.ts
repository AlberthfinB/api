import { Router } from "express";
import {
    createTransaction,
    getTransactionByEventId,
    getTransactionByUserId,
    updateTransactionReview
} from "../controllers/transaction.controller";
import { SingleUploader } from "../utils/uploaderCloudinary";
import { verifyToken } from "../middlewares/auth.middleware";

const transactionRoute = Router();

const { uploadMiddleware } = SingleUploader("payment_proof", "events");

transactionRoute.post(
    "/create",
    verifyToken,
    uploadMiddleware,
    createTransaction);

transactionRoute.patch(
    "/review/:transactionId",
    verifyToken,
    updateTransactionReview);

transactionRoute.get(
    "/event/:eventId",
    verifyToken,
    getTransactionByEventId);

transactionRoute.get(
    "/:userId",
    verifyToken,
    getTransactionByUserId);

export default transactionRoute;