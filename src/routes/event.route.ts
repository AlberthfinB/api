import { Router } from "express";
import { createEvent ,getEventsIncoming , getEventbyId } from "../controllers/event.controller";
import { verifyToken,eventOrganizerGuard } from "../middlewares/auth.middleware";
import { SingleUploader } from "../utils/uploaderCloudinary";


const eventRouter = Router();

const { uploadMiddleware } = SingleUploader("event_image", "events"); 

eventRouter.post("/create-event",verifyToken,eventOrganizerGuard, uploadMiddleware, createEvent);

eventRouter.get("/events-coming",verifyToken, getEventsIncoming );

eventRouter.get("/event/:event_id",getEventbyId);

export default eventRouter;
