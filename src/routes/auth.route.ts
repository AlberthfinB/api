import { Router } from "express";
import { RegisterValidation } from "../middlewares/validations/auth.validation";
import { Register } from "../controllers/auth.controller";

const router = Router();

router.post("/register", RegisterValidation, Register);

export default router;