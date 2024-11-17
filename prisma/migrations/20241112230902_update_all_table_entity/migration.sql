/*
  Warnings:

  - The primary key for the `event` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `create_date` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `event_category_id` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `event_expired` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `event_id` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `image_event` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `name_event` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `promo_event` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `status_event` on the `event` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `event` table. All the data in the column will be lost.
  - You are about to alter the column `description` on the `event` table. The data in that column could be lost. The data in that column will be cast from `VarChar(1000)` to `VarChar(191)`.
  - You are about to alter the column `ticket_price` on the `event` table. The data in that column could be lost. The data in that column will be cast from `Decimal(18,2)` to `Double`.
  - The primary key for the `event_category` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `event_category_id` on the `event_category` table. All the data in the column will be lost.
  - You are about to drop the column `event_category_name` on the `event_category` table. All the data in the column will be lost.
  - The primary key for the `role` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `role_id` on the `role` table. All the data in the column will be lost.
  - You are about to drop the column `role_name` on the `role` table. All the data in the column will be lost.
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
  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `token` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `user` table. All the data in the column will be lost.
  - You are about to alter the column `referal_code` on the `user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(225)` to `VarChar(191)`.
  - The primary key for the `user_point` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `created_date` on the `user_point` table. All the data in the column will be lost.
  - You are about to drop the column `update_at` on the `user_point` table. All the data in the column will be lost.
  - You are about to drop the column `user_point_id` on the `user_point` table. All the data in the column will be lost.
  - You are about to alter the column `points` on the `user_point` table. The data in that column could be lost. The data in that column will be cast from `Decimal(18,2)` to `Int`.
  - You are about to drop the `ticket_type` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `voucher` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[category_name]` on the table `Event_Category` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `Role` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[username]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[referal_code]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `available_seats` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_id` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `date` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `organizer_id` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status_id` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `time` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Event` table without a default value. This is not possible if the table is not empty.
  - Added the required column `category_name` to the `Event_Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Event_Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Event_Category` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Role` table without a default value. This is not possible if the table is not empty.
  - Added the required column `name` to the `Role` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Role` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `payment_status_id` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Transaction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `price` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `quantity` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ticket_id` to the `Transaction_detail` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id` to the `User_Point` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `event` DROP FOREIGN KEY `Event_event_category_id_fkey`;

-- DropForeignKey
ALTER TABLE `event` DROP FOREIGN KEY `Event_ticket_id_fkey`;

-- DropForeignKey
ALTER TABLE `event` DROP FOREIGN KEY `Event_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction` DROP FOREIGN KEY `Transaction_user_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction` DROP FOREIGN KEY `Transaction_voucher_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_Detail_event_id_fkey`;

-- DropForeignKey
ALTER TABLE `transaction_detail` DROP FOREIGN KEY `Transaction_Detail_transaction_id_fkey`;

-- DropForeignKey
ALTER TABLE `user` DROP FOREIGN KEY `User_role_id_fkey`;

-- DropForeignKey
ALTER TABLE `user_point` DROP FOREIGN KEY `User_Point_user_id_fkey`;

-- AlterTable
ALTER TABLE `event` DROP PRIMARY KEY,
    DROP COLUMN `create_date`,
    DROP COLUMN `event_category_id`,
    DROP COLUMN `event_expired`,
    DROP COLUMN `event_id`,
    DROP COLUMN `image_event`,
    DROP COLUMN `name_event`,
    DROP COLUMN `promo_event`,
    DROP COLUMN `status_event`,
    DROP COLUMN `user_id`,
    ADD COLUMN `available_seats` INTEGER NOT NULL,
    ADD COLUMN `category_id` INTEGER NOT NULL,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `date` DATETIME(3) NOT NULL,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `image_url` VARCHAR(191) NULL,
    ADD COLUMN `name` VARCHAR(225) NOT NULL,
    ADD COLUMN `organizer_id` INTEGER NOT NULL,
    ADD COLUMN `status_id` INTEGER NOT NULL,
    ADD COLUMN `time` VARCHAR(191) NOT NULL,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    MODIFY `description` VARCHAR(191) NOT NULL,
    MODIFY `ticket_price` DOUBLE NOT NULL DEFAULT 0.0,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `event_category` DROP PRIMARY KEY,
    DROP COLUMN `event_category_id`,
    DROP COLUMN `event_category_name`,
    ADD COLUMN `category_name` VARCHAR(191) NOT NULL,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `role` DROP PRIMARY KEY,
    DROP COLUMN `role_id`,
    DROP COLUMN `role_name`,
    ADD COLUMN `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `name` VARCHAR(191) NOT NULL,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    ADD PRIMARY KEY (`id`);

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
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `price` DOUBLE NOT NULL,
    ADD COLUMN `quantity` INTEGER NOT NULL,
    ADD COLUMN `ticket_id` INTEGER NOT NULL,
    ADD PRIMARY KEY (`id`);

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `token`,
    DROP COLUMN `user_id`,
    ADD COLUMN `id` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `points` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `updated_at` DATETIME(3) NOT NULL,
    MODIFY `username` VARCHAR(191) NOT NULL,
    MODIFY `referal_code` VARCHAR(191) NOT NULL,
    ADD PRIMARY KEY (`id`);

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
DROP TABLE `ticket_type`;

-- DropTable
DROP TABLE `voucher`;

-- CreateTable
CREATE TABLE `Referral` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `referrer_id` INTEGER NOT NULL,
    `referee_id` INTEGER NOT NULL,
    `points` INTEGER NOT NULL DEFAULT 10000,
    `expiry_date` DATETIME(3) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Ticket` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `ticket_type` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Ticket_ticket_type_key`(`ticket_type`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Event_status` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `status_name` VARCHAR(191) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Review` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NOT NULL,
    `event_id` INTEGER NOT NULL,
    `rating` INTEGER NOT NULL,
    `comment` VARCHAR(191) NOT NULL,
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

-- CreateIndex
CREATE UNIQUE INDEX `Event_Category_category_name_key` ON `Event_Category`(`category_name`);

-- CreateIndex
CREATE UNIQUE INDEX `Role_name_key` ON `Role`(`name`);

-- CreateIndex
CREATE UNIQUE INDEX `User_username_key` ON `User`(`username`);

-- CreateIndex
CREATE UNIQUE INDEX `User_referal_code_key` ON `User`(`referal_code`);

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `Role`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Referral` ADD CONSTRAINT `Referral_referrer_id_fkey` FOREIGN KEY (`referrer_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Referral` ADD CONSTRAINT `Referral_referee_id_fkey` FOREIGN KEY (`referee_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_Point` ADD CONSTRAINT `User_Point_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_category_id_fkey` FOREIGN KEY (`category_id`) REFERENCES `Event_Category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_ticket_id_fkey` FOREIGN KEY (`ticket_id`) REFERENCES `Ticket`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_status_id_fkey` FOREIGN KEY (`status_id`) REFERENCES `Event_status`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_organizer_id_fkey` FOREIGN KEY (`organizer_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Promotion` ADD CONSTRAINT `Promotion_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_payment_status_id_fkey` FOREIGN KEY (`payment_status_id`) REFERENCES `Payment_status`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_detail` ADD CONSTRAINT `Transaction_detail_transaction_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `Transaction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_detail` ADD CONSTRAINT `Transaction_detail_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_detail` ADD CONSTRAINT `Transaction_detail_ticket_id_fkey` FOREIGN KEY (`ticket_id`) REFERENCES `Ticket`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
