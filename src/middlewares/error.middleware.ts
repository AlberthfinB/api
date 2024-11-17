import { Request, Response, NextFunction, ErrorRequestHandler } from "express";

const ErrorMiddleware: ErrorRequestHandler = (err, req: Request, res: Response, next: NextFunction) => {
    if (err.name === 'ValidationError' || err.errors) {
        const formattedError = err.errors.map((error: any) => ({
            msg: error.msg,
            path: error.path
        }))
        res.status(400).json({ errors: formattedError });
    } else {
        res.status(500).json({ message: err.message });
    }
    next();
}

export default ErrorMiddleware; 