import { Router } from "express";
import { createEvent } from "../controllers/event.controller";
import { verifyToken } from "../middlewares/auth.middleware";

const eventRouter = Router();

eventRouter.post("/create-event", verifyToken, createEvent);

export default eventRouter;
