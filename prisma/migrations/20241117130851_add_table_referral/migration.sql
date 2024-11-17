/*
  Warnings:

  - The primary key for the `transaction` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `discount_point` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `discount_voucher` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `payment_code` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `payment_date` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `payment_proof` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `payment_status` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `total_payment` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `transaction_date` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `transaction_id` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `voucher_id` on the `transaction` table. All the data in the column will be lost.
  - You are about to alter the column `total_price` on the `transaction` table. The data in that column could be lost. The data in that column will be cast from `Decimal(18,2)` to `Double`.
  - The primary key for the `transaction_detail` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `transaction_detail_id` on the `transaction_detail` table. All the data in the column will be lost.
  - The primary key for the `user_point` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `created_date` on the `user_point` table. All the data in the column will be lost.
  - You are about to drop the column `update_at` on the `user_point` table. All the data in the column will be lost.
  - You are about to drop the column `user_point_id` on the `user_point` table. All the data in the column will be lost.
  - You are about to alter the column `points` on the `user_point` table. The data in that column could be lost. The data in that column will be cast from `Decimal(18,2)` to `Int`.
  - You are about to drop the `voucher` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `id` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `payment_status_id` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantity` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ticket_id` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `User_Point` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `transaction` DROP FOREIGN KEY `Transaction_voucher_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_Detail_event_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_Detail_transaction_id_fkey`;

-- AlterTable
ALTER TABLE `transaction` DROP PRIMARY KEY,
    DROP COLUMN `discount_point`,
    DROP COLUMN `discount_voucher`,
    DROP COLUMN `payment_code`,
    DROP COLUMN `payment_date`,
    DROP COLUMN `payment_proof`,
    DROP COLUMN `payment_status`,
    DROP COLUMN `total_payment`,
    DROP COLUMN `transaction_date`,
    DROP COLUMN `transaction_id`,
    DROP COLUMN `voucher_id`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `discount` DOUBLE NOT NULL DEFAULT 0.0,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `payment_status_id` INTEGER NOT NULL,
    ADD COLUMN `points_used` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    MODIFY `total_price` DOUBLE NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `transaction_detail` DROP PRIMARY KEY,
    DROP COLUMN `transaction_detail_id`,
    ADD COLUMN `discount` DOUBLE NOT NULL DEFAULT 0.0,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `price` DOUBLE NOT NULL,
    ADD COLUMN `quantity` INTEGER NOT NULL,
    ADD COLUMN `ticket_id` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `user` ADD COLUMN `points` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    MODIFY `password` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `user_point` DROP PRIMARY KEY,
    DROP COLUMN `created_date`,
    DROP COLUMN `update_at`,
    DROP COLUMN `user_point_id`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    MODIFY `points` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- DropTable
DROP TABLE `voucher`;

-- CreateTable
CREATE TABLE `Referral` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `referrer_id` INTEGER NOT NULL,
    `referee_id` INTEGER NOT NULL,
    `referee_role` VARCHAR(191) NOT NULL DEFAULT 'attendee',
    `points` INTEGER NOT NULL DEFAULT 10000,
    `expiry_date` DATETIME(3) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Promotion` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `event_id` INTEGER NOT NULL,
    `type` VARCHAR(191) NOT NULL,
    `discount` DOUBLE NOT NULL,
    `max_uses` INTEGER NOT NULL DEFAULT 0,
    `valid_until` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Payment_status` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    UNIQUE INDEX `Payment_status_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Referral` ADD CONSTRAINT `Referral_referrer_id_fkey` FOREIGN KEY (`referrer_id`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Referral` ADD CONSTRAINT `Referral_referee_id_fkey` FOREIGN KEY (`referee_id`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Promotion` ADD CONSTRAINT `Promotion_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`event_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_payment_status_id_fkey` FOREIGN KEY (`payment_status_id`) REFERENCES `Payment_status`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_detail` ADD CONSTRAINT `Transaction_detail_transaction_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `Transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_detail` ADD CONSTRAINT `Transaction_detail_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`event_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_detail` ADD CONSTRAINT `Transaction_detail_ticket_id_fkey` FOREIGN KEY (`ticket_id`) REFERENCES `Ticket_Type`(`ticket_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
