import express, { Application } from "express";
import { PORT as port } from "./utils/envConfig";
import roleRouter from "./routes/role.route";

const PORT = Number(port) || 7000;

const app: Application = express();
app.use(express.json());
app.use("/role", roleRouter);

app.listen(PORT, () => {
   console.log(`PORT ON ${PORT}`);
});
