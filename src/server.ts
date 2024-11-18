import express, { Application } from "express";
import {BASE_WEB_URL, PORT as port } from "./utils/envConfig";
import ErrorMiddleware from "./middlewares/error.middleware";
import authRouter from "./routes/auth.route";
import firstSeedingData from "./utils/firstSeedingData";
import eventRouter from "./routes/event.route";
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