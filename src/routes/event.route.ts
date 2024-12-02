import { Router } from "express";
import { createEvent ,getEventsIncoming , getEventbyId,getEventsComplete } from "../controllers/event.controller";
import { verifyToken,eventOrganizerGuard } from "../middlewares/auth.middleware";
import { SingleUploader } from "../utils/uploaderCloudinary";


const eventRouter = Router();

const { uploadMiddleware } = SingleUploader("image_event", "events"); 

eventRouter.post("/create-event",verifyToken,eventOrganizerGuard, uploadMiddleware, createEvent);

eventRouter.get("/events-coming", getEventsIncoming );
eventRouter.get("/events-complete", getEventsComplete);
eventRouter.get("/event/:event_id",getEventbyId);

export default eventRouter;
