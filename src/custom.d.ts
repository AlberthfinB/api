export type User = {
    username: string;
    role: string;
}

declare global {
    namespace Express {
        export interface Request {
            user?: User;
        }
    }
}
