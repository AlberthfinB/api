import { Router } from "express";
import { createEvent ,getEventsIncoming } from "../controllers/event.controller";
import { verifyToken,EventOrganizerGuard } from "../middlewares/auth.middleware";
import { SingleUploader } from "../utils/uploaderCloudinary";

const eventRouter = Router();

const { uploadMiddleware } = SingleUploader("event_image", "events"); 

eventRouter.post("/create-event",verifyToken,EventOrganizerGuard, uploadMiddleware, createEvent);

eventRouter.get("/events",verifyToken, getEventsIncoming );

export default eventRouter;
