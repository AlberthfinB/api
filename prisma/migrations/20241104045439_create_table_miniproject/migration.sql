-- CreateTable
CREATE TABLE `User` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(45) NOT NULL,
    `password` VARCHAR(15) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `referal_code` VARCHAR(225) NOT NULL,
    `token` VARCHAR(225) NOT NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `role_id` INTEGER NOT NULL,

    UNIQUE INDEX `User_email_key`(`email`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Role` (
    `role_id` INTEGER NOT NULL AUTO_INCREMENT,
    `role_name` ENUM('EventOrganizer', 'Attendant') NOT NULL,

    PRIMARY KEY (`role_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `User_Point` (
    `user_point_id` INTEGER NOT NULL AUTO_INCREMENT,
    `points` DECIMAL(18, 2) NOT NULL,
    `created_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expiry_date` DATETIME(3) NOT NULL,
    `update_at` DATETIME(3) NOT NULL,
    `user_id` INTEGER NOT NULL,

    PRIMARY KEY (`user_point_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Event` (
    `event_id` INTEGER NOT NULL AUTO_INCREMENT,
    `name_event` VARCHAR(225) NOT NULL,
    `location` VARCHAR(225) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,
    `image_event` MEDIUMBLOB NULL,
    `ticket_price` DECIMAL(18, 2) NOT NULL,
    `promo_event` DECIMAL(18, 2) NOT NULL,
    `seats` INTEGER NOT NULL,
    `status_event` ENUM('Published', 'Completed') NOT NULL,
    `create_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `event_expired` DATETIME(3) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `ticket_id` INTEGER NOT NULL,
    `event_category_id` INTEGER NOT NULL,

    PRIMARY KEY (`event_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Ticket_Type` (
    `ticket_id` INTEGER NOT NULL AUTO_INCREMENT,
    `ticket_type` ENUM('Paid', 'Free') NOT NULL,

    PRIMARY KEY (`ticket_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Event_Category` (
    `event_category_id` INTEGER NOT NULL AUTO_INCREMENT,
    `event_category_name` ENUM('Music', 'Workshop', 'Food', 'Travel') NOT NULL,

    PRIMARY KEY (`event_category_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction_Detail` (
    `transaction_detail_id` INTEGER NOT NULL AUTO_INCREMENT,
    `event_id` INTEGER NOT NULL,
    `transaction_id` INTEGER NOT NULL,

    PRIMARY KEY (`transaction_detail_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Transaction` (
    `transaction_id` INTEGER NOT NULL AUTO_INCREMENT,
    `transaction_date` VARCHAR(50) NOT NULL,
    `payment_status` BOOLEAN NOT NULL DEFAULT false,
    `payment_proof` VARCHAR(100) NOT NULL,
    `payment_date` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `total_payment` DECIMAL(18, 2) NOT NULL,
    `payment_code` VARCHAR(100) NOT NULL,
    `discount_point` DECIMAL(18, 2) NOT NULL,
    `discount_voucher` DECIMAL(18, 2) NOT NULL,
    `total_price` DECIMAL(18, 2) NOT NULL,
    `user_id` INTEGER NOT NULL,
    `voucher_id` INTEGER NOT NULL,

    UNIQUE INDEX `Transaction_voucher_id_key`(`voucher_id`),
    PRIMARY KEY (`transaction_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Voucher` (
    `voucher_id` INTEGER NOT NULL AUTO_INCREMENT,

    PRIMARY KEY (`voucher_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `Role`(`role_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `User_Point` ADD CONSTRAINT `User_Point_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_ticket_id_fkey` FOREIGN KEY (`ticket_id`) REFERENCES `Ticket_Type`(`ticket_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Event` ADD CONSTRAINT `Event_event_category_id_fkey` FOREIGN KEY (`event_category_id`) REFERENCES `Event_Category`(`event_category_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_Detail` ADD CONSTRAINT `Transaction_Detail_event_id_fkey` FOREIGN KEY (`event_id`) REFERENCES `Event`(`event_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction_Detail` ADD CONSTRAINT `Transaction_Detail_transaction_id_fkey` FOREIGN KEY (`transaction_id`) REFERENCES `Transaction`(`transaction_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Transaction` ADD CONSTRAINT `Transaction_voucher_id_fkey` FOREIGN KEY (`voucher_id`) REFERENCES `Voucher`(`voucher_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
