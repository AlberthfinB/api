import express, { Application } from "express";
import {BASE_WEB_URL, PORT as port } from "./utils/envConfig";
import ErrorMiddleware from "./middlewares/error.middleware";
import authRouter from "./routes/auth.route";
import firstSeedingData from "./utils/firstSeedingData";
import eventRouter from "./routes/event.route";
import ticketRouter from "./routes/ticket.route";
import promotionType from "./routes/promotion.type.route";
import reviewRouter from "./routes/event.review.route";
import pointRoute from "./routes/point.route";
import couponRoute from "./routes/coupon.route";
import transactionRoute from "./routes/transaction.route";
import categoryRouter from "./routes/category.route";
import cors from "cors";


const PORT = Number(port) || 7000;

const app: Application = express();

app.use(express.json());

app.use(
    cors({
       origin: BASE_WEB_URL || "http://localhost:3000",
       credentials: true,
    })
 );

app.use("/management", eventRouter);
app.use('/auth', authRouter);
app.use("/master",categoryRouter);
app.use("/master",ticketRouter);
app.use("/master",promotionType)
app.use("/master",reviewRouter);
app.use("/user", pointRoute);
app.use("/user", couponRoute);
app.use("/transaction", transactionRoute);

app.use(ErrorMiddleware);

const startServer = async () => {
    try {
        await firstSeedingData();
        console.log("Database seeded successfully");

        app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
    } catch (error) {
        console.error("Error starting server: ", error);
        process.exit(1);
    }
};

startServer();