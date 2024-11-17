export type User = {
    name: string;
    email: string;
    role: string;
}

declare global {
    namespace Express {
        export interface Request {
            user?: User;
        }
    }
}
