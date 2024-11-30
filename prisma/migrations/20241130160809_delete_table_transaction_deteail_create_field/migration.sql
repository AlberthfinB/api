/*
  Warnings:

  - You are about to drop the column `promo_event` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `promotion` table. All the data in the column will be lost.
  - You are about to drop the `transaction_detail` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `available_seats` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `promotion_type_id` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `promotion_type_id` to the `Promotion` table without a default value. This is not possible if the table is not empty.
  - Added the required column `event_id` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantity` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ticket_id` to the `Transaction` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_detail_event_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_detail_ticket_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_detail_transaction_id_fkey`;

-- AlterTable
ALTER TABLE `event` DROP COLUMN `promo_event`,
    ADD COLUMN `available_seats` INTEGER NOT NULL,
    ADD COLUMN `promotion_type_id` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `promotion` DROP COLUMN `type`,
    ADD COLUMN `promotion_type_id` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `transaction` ADD COLUMN `discount_event` DOUBLE NOT NULL DEFAULT 0.0,
    ADD COLUMN `event_id` INTEGER NOT NULL,
    ADD COLUMN `payment_proof` VARCHAR(191) NULL,
    ADD COLUMN `price` DOUBLE NOT NULL,
    ADD COLUMN `quantity` INTEGER NOT NULL,
    ADD COLUMN `review` VARCHAR(191) NULL,
    ADD COLUMN `ticket_id` INTEGER NOT NULL;

-- DropTable
DROP TABLE `transaction_detail`;

-- CreateTable
CREATE TABLE `Promotion_Type` (
    `promotion_type_id` INTEGER NOT NULL AUTO_INCREMENT,
    `promotion_type` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Promotion_Type_promotion_type_key`(`promotion_type`),
    PRIMARY KEY (`promotion_type_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_promotion_type_id_fkey` FOREIGN KEY (`promotion_type_id`) REFERENCES `Promotion_Type`(`promotion_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Promotion` ADD CONSTRAINT `Promotion_promotion_type_id_fkey` FOREIGN KEY (`promotion_type_id`) REFERENCES `Promotion_Type`(`promotion_type_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`event_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_ticket_id_fkey` FOREIGN KEY (`ticket_id`) REFERENCES `Ticket_Type`(`ticket_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
