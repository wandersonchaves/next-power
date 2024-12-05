import {prisma} from '@/lib/prisma'
import {logError} from '@/utils/logger'

interface GetCustomersParams {
  page?: number
  limit?: number
}

export const getCustomers = async ({
  page = 1,
  limit = 10,
}: GetCustomersParams) => {
  const skip = (page - 1) * limit

  try {
    const [customers, total] = await prisma.$transaction([
      prisma.customer.findMany({
        skip,
        take: limit,
        orderBy: {createdAt: 'desc'},
        select: {
          id: true,
          name: true,
          cpf: true,
          email: true,
          phone: true,
          createdAt: true,
          carnetGenerated: true,
          carnets: true,
        },
      }),
      prisma.customer.count(),
    ])

    return {
      customers,
      total,
      currentPage: page,
      totalPages: Math.ceil(total / limit),
    }
  } catch (error) {
    logError('Erro ao buscar customers:', error)
    throw new Error('Erro ao buscar clientes do banco de dados')
  }
}
