import { Router } from "express";
import { getCouponByUser } from "../controllers/coupon.controller";
const couponRoute = Router();

couponRoute.get("/coupon",getCouponByUser);

export default couponRoute;