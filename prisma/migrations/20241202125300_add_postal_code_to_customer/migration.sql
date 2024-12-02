/*
  Warnings:

  - A unique constraint covering the columns `[cpf]` on the table `Customer` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `birthDate` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cpf` to the `Customer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `timestamp` to the `Customer` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Customer" ADD COLUMN     "address" TEXT,
ADD COLUMN     "birthDate" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "cpf" TEXT NOT NULL,
ADD COLUMN     "points" INTEGER,
ADD COLUMN     "postalCode" TEXT,
ADD COLUMN     "spouseName" TEXT,
ADD COLUMN     "timestamp" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Customer_cpf_key" ON "Customer"("cpf");
