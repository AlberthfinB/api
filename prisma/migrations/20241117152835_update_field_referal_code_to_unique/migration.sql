/*
  Warnings:

  - You are about to alter the column `referal_code` on the `user` table. The data in that column could be lost. The data in that column will be cast from `VarChar(225)` to `VarChar(191)`.
  - A unique constraint covering the columns `[referal_code]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `user` MODIFY `referal_code` VARCHAR(191) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX `User_referal_code_key` ON `User`(`referal_code`);
