import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

async function firstSeedingData() {
    const roles = ['Attendee', 'Event Organizer'];
    for (const role of roles) {
        await prisma.role.upsert({
            where: { role_name: role },
            update: {},
            create: { role_name: role },
        });
    }

    const types = ['Free', 'Paid'];
    for (const type of types) {
        await prisma.ticket_Type.upsert({
            where: { ticket_type: type },
            update: {},
            create: { ticket_type: type },
        })
    }

    const eventStatuses = ['Published', 'Ongoing', 'Canceled', 'Completed'];
    for (const status of eventStatuses) {
        await prisma.status_Event.upsert({
            where: { status_name: status },
            update: {},
            create: { status_name: status },
        });
    }

    const eventCategories = ['Concert', 'Workshop', 'Travel'];
    for (const category of eventCategories) {
        await prisma.event_Category.upsert({
            where: { event_category_name: category },
            update: {},
            create: { event_category_name: category },
        });
    }

    const paymentStatuses = ['Paid', 'Unpaid', 'Refunded'];
    for (const status of paymentStatuses) {
        await prisma.payment_status.upsert({
            where: { name: status },
            update: {},
            create: { name: status },
        });
    }
}

export default firstSeedingData;