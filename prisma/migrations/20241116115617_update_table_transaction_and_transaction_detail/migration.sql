-- AlterTable
ALTER TABLE `transaction` ADD COLUMN `coupon_id` INTEGER NULL;

-- AlterTable
ALTER TABLE `transaction_detail` ADD COLUMN `discount` DOUBLE NOT NULL DEFAULT 0.0;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_coupon_id_fkey` FOREIGN KEY (`coupon_id`) REFERENCES `Coupon`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
