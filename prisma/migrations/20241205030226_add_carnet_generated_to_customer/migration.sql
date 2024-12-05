/*
  Warnings:

  - You are about to drop the column `carnetCoverPdf` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `carnetPdf` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `carnetStatus` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Carnet` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `Charge` table. All the data in the column will be lost.
  - You are about to drop the column `isCarnetPaid` on the `Customer` table. All the data in the column will be lost.
  - You are about to drop the column `points` on the `Customer` table. All the data in the column will be lost.
  - You are about to drop the column `timestamp` on the `Customer` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[carnetId]` on the table `Carnet` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[chargeId]` on the table `Charge` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `cover` to the `Carnet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `history` to the `Carnet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `link` to the `Carnet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pdf` to the `Carnet` table without a default value. This is not possible if the table is not empty.
  - Added the required column `status` to the `Carnet` table without a default value. This is not possible if the table is not empty.
  - Made the column `carnetId` on table `Carnet` required. This step will fail if there are existing NULL values in that column.
  - Made the column `carnetLink` on table `Carnet` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `configurations` to the `Charge` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `Charge` table without a default value. This is not possible if the table is not empty.
  - Made the column `chargeId` on table `Charge` required. This step will fail if there are existing NULL values in that column.
  - Made the column `url` on table `Charge` required. This step will fail if there are existing NULL values in that column.
  - Made the column `pdf` on table `Charge` required. This step will fail if there are existing NULL values in that column.
  - Made the column `barcode` on table `Charge` required. This step will fail if there are existing NULL values in that column.
  - Made the column `pixQrCode` on table `Charge` required. This step will fail if there are existing NULL values in that column.
  - Made the column `pixQrImage` on table `Charge` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Carnet" DROP COLUMN "carnetCoverPdf",
DROP COLUMN "carnetPdf",
DROP COLUMN "carnetStatus",
DROP COLUMN "updatedAt",
ADD COLUMN     "cover" TEXT NOT NULL,
ADD COLUMN     "history" JSONB NOT NULL,
ADD COLUMN     "link" TEXT NOT NULL,
ADD COLUMN     "pdf" TEXT NOT NULL,
ADD COLUMN     "status" TEXT NOT NULL,
ALTER COLUMN "carnetId" SET NOT NULL,
ALTER COLUMN "carnetLink" SET NOT NULL;

-- AlterTable
ALTER TABLE "Charge" DROP COLUMN "updatedAt",
ADD COLUMN     "configurations" JSONB NOT NULL,
ADD COLUMN     "value" INTEGER NOT NULL,
ALTER COLUMN "chargeId" SET NOT NULL,
ALTER COLUMN "url" SET NOT NULL,
ALTER COLUMN "pdf" SET NOT NULL,
ALTER COLUMN "barcode" SET NOT NULL,
ALTER COLUMN "pixQrCode" SET NOT NULL,
ALTER COLUMN "pixQrImage" SET NOT NULL;

-- AlterTable
ALTER TABLE "Customer" DROP COLUMN "isCarnetPaid",
DROP COLUMN "points",
DROP COLUMN "timestamp",
ADD COLUMN     "carnetGenerated" BOOLEAN NOT NULL DEFAULT false;

-- CreateIndex
CREATE UNIQUE INDEX "Carnet_carnetId_key" ON "Carnet"("carnetId");

-- CreateIndex
CREATE UNIQUE INDEX "Charge_chargeId_key" ON "Charge"("chargeId");
