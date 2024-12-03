import { Request, Response, NextFunction } from "express";
import { verify } from "jsonwebtoken";
import { SECRET_KEY } from "../utils/envConfig";
import { User } from "../custom";

async function verifyToken(req: Request, res: Response, next: NextFunction) {
   try {
      const token = req.header('Authorization')?.replace('Bearer ', '');
      //   console.log(`Received token: ${token}`);
      if (!token) throw new Error('Unathorized');

      const user = verify(token, SECRET_KEY as string);
      //   console.log(`Verified token for user: ${JSON.stringify(user)}`);
      if (!user) throw new Error('Unathorized');
      req.user = user as User;

      next();
   } catch (error) {
      next(error);
   }
}

async function eventOrganizerGuard(
   req: Request,
   res: Response,
   next: NextFunction
) {
   try {
      if (req.user?.role !== "Event Organizer")
         throw new Error("Not an Event Organizer");

      next();
   } catch (err) {
      next(err);
   }
}
export { verifyToken, eventOrganizerGuard };