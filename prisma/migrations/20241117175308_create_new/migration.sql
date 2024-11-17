/*
  Warnings:

  - You are about to drop the column `status_event` on the `event` table. All the data in the column will be lost.
  - Added the required column `status_event_id` to the `Event` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `event` DROP COLUMN `status_event`,
    ADD COLUMN `status_event_id` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `Status_Event` (
    `status_event_id` INTEGER NOT NULL AUTO_INCREMENT,
    `status_name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Status_Event_status_name_key`(`status_name`),
    PRIMARY KEY (`status_event_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_status_event_id_fkey` FOREIGN KEY (`status_event_id`) REFERENCES `Status_Event`(`status_event_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
