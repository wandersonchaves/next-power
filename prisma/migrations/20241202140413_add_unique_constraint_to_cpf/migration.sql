/*
  Warnings:

  - Made the column `points` on table `Customer` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "Customer_email_key";

-- AlterTable
ALTER TABLE "Customer" ALTER COLUMN "birthDate" DROP NOT NULL,
ALTER COLUMN "points" SET NOT NULL,
ALTER COLUMN "timestamp" DROP NOT NULL;
