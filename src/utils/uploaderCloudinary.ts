import multer from "multer";
import { v2 as cloudinary } from "cloudinary";

interface CloudinaryUploadResponse {
   public_id: string;
   version: number;
   signature: string;
   width: number;
   height: number;
   format: string;
   resource_type: string;
   url: string;
   secure_url: string;
   created_at: string;
   bytes: number;
   original_filename: string;
}

export const SingleUploader = (filePrefix: string, folderName?: string) => {
   const maxSize = 5 * 1024 * 1024; //  MB

   const storage = multer.memoryStorage();

   const upload = multer({
      storage: storage,
      limits: { fileSize: maxSize },
   }).single("image_event");

   const uploadToCloudinary = async (file: Express.Multer.File) => {
      return new Promise<CloudinaryUploadResponse>((resolve, reject) => {
         const folder = folderName || "events";
         cloudinary.uploader
            .upload_stream(
               {
                  folder:folder, 
                  public_id: filePrefix + Date.now(),
               },
               (error, result) => {
                  if (error) {
                     return reject(error);
                  }
                  console.log("Upload Result:", result);
                  resolve(result as CloudinaryUploadResponse);
               }
            )
            .end(file.buffer);
      });
   };
  
   return {
      uploadMiddleware: upload,
      uploadToCloudinary: uploadToCloudinary,
   };
};
