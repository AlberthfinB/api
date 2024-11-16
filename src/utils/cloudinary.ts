import { v2 as cloudinary, UploadApiResponse } from "cloudinary";
import * as streamifier from "streamifier";
import {
   CLOUDINARY_API_KEY,
   CLOUDINARY_CLOUD_NAME,
   CLOUDINARY_API_SECRET,
} from "./envConfig";

cloudinary.config({
   cloud_name: CLOUDINARY_CLOUD_NAME || "",
   api_key: CLOUDINARY_API_KEY || "",
   api_secret: CLOUDINARY_API_SECRET || "",
});

export const cloudinaryUpload = (
   file: Express.Multer.File
): Promise<UploadApiResponse> => {
   return new Promise((resolve, reject) => {
      if (!(file.buffer instanceof Buffer)) {
         return reject(new Error("File buffer is not a valid Buffer instance"));
      }
      const uploadStream = cloudinary.uploader.upload_stream(
         (error, result: UploadApiResponse) => {
            if (error) {
               console.log("error");
               return reject(error);
            }
            resolve(result);
         }
      );
      streamifier.createReadStream(file.buffer).pipe(uploadStream);
   });
};
