import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient();

async function main() {
    await prisma.role.createMany({
        data: [
            { name: 'Attendee' },
            { name: 'Organizer' },
        ],
        skipDuplicates: true,
    })

    await prisma.ticket.createMany({
        data: [
            { ticket_type: 'Free' },
            { ticket_type: 'Paid' },
        ],
        skipDuplicates: true,
    });

    await prisma.event_status.createMany({
        data: [
            { status_name: 'Published' },
            { status_name: 'Ongoing' },
            { status_name: 'Canceled' },
        ],
        skipDuplicates: true,
    });

    await prisma.event_category.createMany({
        data: [
            { category_name: 'Concert' },
            { category_name: 'Workshop' },
            { category_name: 'Travel' },
        ],
        skipDuplicates: true,
    });

    await prisma.payment_status.createMany({
        data: [
            { name: 'Paid' },
            { name: 'Unpaid' },
            { name: 'Refunded' },
        ],
        skipDuplicates: true,
    });
}

main().then(async () => {
    await prisma.$disconnect();
}).catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
});