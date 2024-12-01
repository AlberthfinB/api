-- AlterTable
ALTER TABLE `referral` MODIFY `referee_role` VARCHAR(191) NOT NULL DEFAULT 'attendee';

-- AlterTable
ALTER TABLE `user` MODIFY `referal_code` VARCHAR(191) NULL;
