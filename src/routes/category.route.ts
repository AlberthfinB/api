import { Router } from "express";
import { getAllCategory } from "../controllers/category.controller";

const categoryRouter = Router();

categoryRouter.get("/category",getAllCategory);


export default categoryRouter;

