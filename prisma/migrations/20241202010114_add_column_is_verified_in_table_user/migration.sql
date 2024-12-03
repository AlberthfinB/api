-- AlterTable
ALTER TABLE `referral` MODIFY `referee_role` VARCHAR(191) NOT NULL DEFAULT 'attendee';

-- AlterTable
ALTER TABLE `user` ADD COLUMN `isVerified` BOOLEAN NOT NULL DEFAULT false;
