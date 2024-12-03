import {NextResponse} from 'next/server'

import {getCustomers} from '@/services/customerService'
import {logError} from '@/utils/logger'

export async function GET(req: Request) {
  try {
    const url = new URL(req.url)
    const page = parseInt(url.searchParams.get('page') || '1', 10)
    const limit = parseInt(url.searchParams.get('limit') || '10', 10)

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
