/*
  Warnings:

  - You are about to drop the column `pdfCarnet` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `pdfCover` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `barcode` on the `Charge` table. All the data in the column will be lost.
  - You are about to drop the column `pdf` on the `Charge` table. All the data in the column will be lost.
  - You are about to drop the column `pixQrCode` on the `Charge` table. All the data in the column will be lost.
  - You are about to drop the column `pixQrImage` on the `Charge` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Carnet" DROP COLUMN "pdfCarnet",
DROP COLUMN "pdfCover";

-- AlterTable
ALTER TABLE "Charge" DROP COLUMN "barcode",
DROP COLUMN "pdf",
DROP COLUMN "pixQrCode",
DROP COLUMN "pixQrImage";
