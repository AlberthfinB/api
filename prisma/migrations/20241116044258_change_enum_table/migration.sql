/*
  Warnings:

  - You are about to alter the column `event_category_name` on the `event_category` table. The data in that column could be lost. The data in that column will be cast from `Enum(EnumId(0))` to `VarChar(191)`.

*/
-- AlterTable
ALTER TABLE `event_category` MODIFY `event_category_name` VARCHAR(191) NOT NULL;
