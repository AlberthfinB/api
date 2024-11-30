import { Router } from "express";
import { getPromotionType } from "../controllers/promotion.type.controller";

const promotionType = Router();

promotionType.get("/promotion-type",getPromotionType);

export default promotionType;