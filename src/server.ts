import express, { Application } from "express";
import { PORT as port } from "./utils/envConfig";
import ErrorMiddleware from "./middlewares/error.middleware";
import authRouter from "./routes/auth.route";
import firstSeedingData from "./utils/firstSeedingData";

const PORT = Number(port) || 7000;

const app: Application = express();

app.use(express.json());
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