import { Router } from "express";
import { createEvent } from "../controllers/event.controller";

const eventRouter = Router();

eventRouter.post("/create-event", createEvent);

export default eventRouter;
