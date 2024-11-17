import express, { Application } from "express";
import { PORT as port } from "./utils/envConfig";
import errorMiddleware from "./middlewares/error.middleware";
import eventRouter from "./routes/event.route";

const PORT = Number(port) || 7000;

const app: Application = express();
app.use(express.json());

app.use("/management", eventRouter);

app.use(errorMiddleware);

app.listen(PORT, () => {
   console.log(`PORT ON ${PORT}`);
});
