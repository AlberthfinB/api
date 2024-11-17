import { Request, Response, NextFunction } from "express";
import { body, validationResult } from "express-validator";

export const RegisterValidation = [
    body("username")
        .notEmpty().withMessage("Username is required")
        .isLength({ min: 3 }).withMessage("Username must be at least 3 characters long"),
    body("email")
        .notEmpty().withMessage("Email is required")
        .isEmail().withMessage("Email is invalid"),
    body("password")
        .notEmpty().withMessage('Password is required')
        .isLength({ min: 6 }).withMessage('Password must be at least 6 characters long')
        .matches(/(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*])/).withMessage('Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character'),
    (req: Request, res: Response, next: NextFunction) => {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            const error = new Error('Validation Error');
            error.name = 'ValidationError';
            (error as any).errors = errors.array();
            return next(error);
        }
        next();
    }
];