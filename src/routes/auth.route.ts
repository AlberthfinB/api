import { Router } from "express";
import { LoginValidation, RegisterValidation } from "../middlewares/validations/auth.validation";
import { Login, Register } from "../controllers/auth.controller";

const router = Router();

router.post("/register", RegisterValidation, Register);
router.post("/login", LoginValidation, Login);

export default router;