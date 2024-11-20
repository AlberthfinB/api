import { v2 as cloudinary, UploadApiResponse, UploadApiErrorResponse } from "cloudinary";
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
         {
            folder: "events",
            transformation: [
               {
                  width: 500, 
                  height: 300, 
                  crop: "fill", 
                  gravity: "auto", 
               },
            ],
         },
         (error: UploadApiErrorResponse | undefined, result: UploadApiResponse | undefined) => {
            if (error) {
               console.log("Error uploading to Cloudinary:", error);
               return reject(error);
            }
            if (!result) {
               return reject(new Error("No result returned from Cloudinary"));
            }
            resolve(result);  
         }
      );

      streamifier.createReadStream(file.buffer).pipe(uploadStream);
   });
};
