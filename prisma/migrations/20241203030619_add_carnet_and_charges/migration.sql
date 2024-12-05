/*
  Warnings:

  - You are about to drop the column `carnetUrl` on the `Customer` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Customer" DROP COLUMN "carnetUrl",
ALTER COLUMN "points" SET DEFAULT 0;

-- CreateTable
CREATE TABLE "Carnet" (
    "id" TEXT NOT NULL,
    "customerId" TEXT NOT NULL,
    "carnetId" TEXT,
    "carnetStatus" TEXT NOT NULL,
    "carnetLink" TEXT,
    "carnetPdf" TEXT,
    "carnetCoverPdf" TEXT,
    "value" INTEGER NOT NULL,
    "repeats" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Carnet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Charge" (
    "id" TEXT NOT NULL,
    "carnetId" TEXT NOT NULL,
    "chargeId" TEXT,
    "parcel" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "url" TEXT,
    "pdf" TEXT,
    "barcode" TEXT,
    "pixQrCode" TEXT,
    "pixQrImage" TEXT,
    "expireAt" TIMESTAMP(3) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Charge_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Carnet" ADD CONSTRAINT "Carnet_customerId_fkey" FOREIGN KEY ("customerId") REFERENCES "Customer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Charge" ADD CONSTRAINT "Charge_carnetId_fkey" FOREIGN KEY ("carnetId") REFERENCES "Carnet"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
