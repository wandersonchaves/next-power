import {prisma} from '@/lib/prisma'
import {Carnet, type CustomerData} from '@/types/Carnet'

export const saveCarnetData = async (
  carnet: Carnet,
  customer: CustomerData,
) => {
  try {
    if (!carnet || !customer) {
      throw new Error('Carnet ou Customer não podem ser nulos.')
    }

    const existingCustomer = await prisma.customer.findUnique({
      where: {cpf: customer.cpf},
    })

    if (!existingCustomer) {
      throw new Error(`Inscrito com CPF ${customer.cpf} não encontrado.`)
    }

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
        pdf: JSON.stringify(carnet.pdf),
        createdAt: carnet.createdAt || new Date(),
        customerId: existingCustomer.id,
        history: JSON.stringify(carnet.history || []),
        charges: {
          create: Array.isArray(carnet.charges)
            ? carnet.charges.map((charge) => ({
                chargeId: charge.chargeId,
                parcel: charge.parcel,
                status: charge.status,
                value: charge.value,
                expireAt: charge.expireAt,
                url: charge.url,
                pdf: charge.pdf,
                barcode: charge.barcode,
                pixQrCode: charge.pixQrCode || '',
                pixQrImage: charge.pixQrImage || '',
                configurations: JSON.stringify(charge.configurations || {}),
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
        pdf: JSON.stringify(carnet.pdf),
        history: JSON.stringify(carnet.history || []),
      },
    })

    return carnetRecord
  } catch (error) {
    console.error('Erro ao salvar dados do carnê:', error)
    throw new Error('Erro ao salvar dados no banco de dados.')
  }
}
