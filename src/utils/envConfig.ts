import { config } from "dotenv";
config({
   path: ".env",
});
export const { PORT, SECRET_KEY, CLOUDINARY_CLOUD_NAME, CLOUDINARY_API_KEY, CLOUDINARY_API_SECRET } = process.env;
