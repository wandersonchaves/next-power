import {NextResponse} from 'next/server'
import {getServerSession} from 'next-auth'

import {authOptions} from '../auth/[...nextauth]/auth-options'

import {prisma} from '@/lib/prisma'
import {customerSchema} from '@/schemas/customerSchema'
import {getCustomers} from '@/services/customerService'
import {logError} from '@/utils/logger'

export async function GET(req: Request) {
  try {
    const url = new URL(req.url)
    const page = parseInt(url.searchParams.get('page') ?? '1', 10)
    const limit = parseInt(url.searchParams.get('limit') ?? '10', 10)

    const customersData = await getCustomers({page, limit})

    return NextResponse.json(customersData)
  } catch (error: unknown) {
    if (error instanceof Error) {
      logError('Erro na API de busca de customers:', error.message)
      return NextResponse.json(
        {message: 'Erro ao buscar clientes', error: error.message},
        {status: 500},
      )
    } else {
      logError('Erro desconhecido na API de busca de customers:', error)
      return NextResponse.json(
        {message: 'Erro ao buscar clientes', error: 'Erro desconhecido'},
        {status: 500},
      )
    }
  }
}

export async function POST(request: Request) {
  try {
    const session = await getServerSession(authOptions)

    if (!session || !session.user || !session.user.id) {
      return NextResponse.json(
        {message: 'Usuário não autenticado ou ID de usuário ausente.'},
        {status: 401},
      )
    }

    const userId = session.user.id

    const payload = await request.json()

    if (!payload) {
      return new Response(JSON.stringify({error: 'O payload está vazio.'}), {
        status: 400,
      })
    }

    const validatedData = customerSchema.parse(payload)

    const newCustomer = await prisma.customer.create({
      data: {
        ...validatedData,
        user: {connect: {id: userId}},
      },
    })

    return new Response(JSON.stringify(newCustomer), {status: 201})
  } catch (err) {
    console.error(err)

    return new Response(
      JSON.stringify({error: 'Erro ao processar o pedido.', details: err}),
      {status: 500},
    )
  }
}
