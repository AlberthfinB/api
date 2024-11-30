import { Router } from "express";
import { getCategory } from "../controllers/category.controller";

const categoryRouter = Router();

categoryRouter.get("/category",getCategory);


export default categoryRouter;

