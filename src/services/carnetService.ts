import {prisma} from '@/lib/prisma'
import type {CarnetOutput} from '@/types/Carnet'
import type {CustomerData} from '@/types/Customer'

export const saveCarnetData = async (
  carnet: CarnetOutput,
  customer: CustomerData,
) => {
  if (!carnet || !customer) {
    throw new Error('Carnet ou Customer não podem ser nulos.')
  }

  try {
    const existingCustomer = await prisma.customer.findUnique({
      where: {cpf: customer.cpf},
    })

    if (!existingCustomer) {
      throw new Error(`Inscrito com CPF ${customer.cpf} não encontrado.`)
    }

    await prisma.customer.update({
      where: {cpf: customer.cpf},
      data: {carnetGenerated: true},
    })

    const carnetRecord = await prisma.carnet.upsert({
      where: {carnetId: carnet.carnetId},
      create: {
        carnetId: carnet.carnetId,
        status: carnet.status,
        repeats: carnet.repeats,
        value: carnet.value,
        cover: carnet.cover,
        link: carnet.link,
        carnetLink: carnet.carnetLink ?? '',
        customerId: existingCustomer.id,
        charges: {
          create: Array.isArray(carnet.charges)
            ? carnet.charges.map((charge) => ({
                chargeId: charge.chargeId,
                parcel: charge.parcel,
                status: charge.status,
                value: charge.value,
                expireAt: charge.expireAt,
                url: charge.url,
              }))
            : [],
        },
      },
      update: {
        status: carnet.status,
        value: carnet.value,
        cover: carnet.cover,
        link: carnet.link,
        carnetLink: carnet.carnetLink ?? '',
      },
    })

    return carnetRecord
  } catch (error) {
    console.error('Erro ao salvar dados do carnê:', error)
    throw new Error('Erro ao salvar dados no banco de dados.')
  }
}
