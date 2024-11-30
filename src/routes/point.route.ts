import { Router } from "express";
import { getPointByUser } from "../controllers/point.controller";

const pointRoute = Router();

pointRoute.get("/point",getPointByUser);

export default pointRoute;