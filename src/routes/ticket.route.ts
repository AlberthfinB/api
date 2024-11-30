import { Router } from "express";
import { getTicketType } from "../controllers/ticket.controller";

const ticketRouter = Router();

ticketRouter.get("/ticket",getTicketType);

export default ticketRouter;