/*
  Warnings:

  - You are about to alter the column `status_event` on the `event` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(3))` to `VarChar(191)`.
  - You are about to alter the column `role_name` on the `role` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(0))` to `VarChar(191)`.
  - You are about to alter the column `ticket_type` on the `ticket_type` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(1))` to `VarChar(191)`.
  - You are about to drop the column `token` on the `user` table. All the data in the column will be lost.
  - You are about to drop the column `username` on the `user` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[role_name]` on the table `Role` will be added. If there are existing duplicate values, this will fail.
  - Made the column `image_event` on table `event` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `name` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `event` MODIFY `image_event` VARCHAR(191) NOT NULL,
    MODIFY `promo_event` VARCHAR(191) NOT NULL,
    MODIFY `status_event` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `role` MODIFY `role_name` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `ticket_type` MODIFY `ticket_type` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `user` DROP COLUMN `token`,
    DROP COLUMN `username`,
    ADD COLUMN `name` VARCHAR(45) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Role_role_name_key` ON `Role`(`role_name`);
