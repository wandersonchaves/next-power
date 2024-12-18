/*
  Warnings:

  - You are about to drop the column `pdf` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `configurations` on the `Charge` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Customer" DROP CONSTRAINT "Customer_userId_fkey";

-- AlterTable
ALTER TABLE "Carnet" DROP COLUMN "pdf",
ADD COLUMN     "pdfCarnet" TEXT,
ADD COLUMN     "pdfCover" TEXT;

-- AlterTable
ALTER TABLE "Charge" DROP COLUMN "configurations",
ALTER COLUMN "pixQrCode" DROP NOT NULL,
ALTER COLUMN "pixQrImage" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Customer" ADD CONSTRAINT "Customer_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
