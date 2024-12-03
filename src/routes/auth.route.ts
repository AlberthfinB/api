import { Router } from "express";
import { LoginValidation, RegisterValidation } from "../middlewares/validations/auth.validation";
import { getReferralCode, Login, Register, VerifyUser } from "../controllers/auth.controller";
import { verifyToken } from "../middlewares/auth.middleware";

const router = Router();

router.post("/register", RegisterValidation, Register);
router.post("/login", LoginValidation, Login);
router.get("/verify", verifyToken, VerifyUser);
router.get("/referral-code", verifyToken, getReferralCode);

export default router;