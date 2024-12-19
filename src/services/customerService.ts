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
        orderBy: {name: 'asc'},
        include: {
          carnets: {
            include: {
              charges: true,
            },
          },
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
