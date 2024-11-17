/*
  Warnings:

  - A unique constraint covering the columns `[status_name]` on the table `Event_status` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `Event_status_status_name_key` ON `Event_status`(`status_name`);
