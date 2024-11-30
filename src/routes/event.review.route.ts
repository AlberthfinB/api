import {
    createReview,
   
} from "../controllers/event.review.controller";
import { Router } from "express";
import { verifyToken } from "../middlewares/auth.middleware";

const reviewRouter = Router();

reviewRouter.post("/create-review", verifyToken, createReview);

export default reviewRouter;