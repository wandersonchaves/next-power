import {NextResponse} from 'next/server'

import {createCarnet} from '@/services/efipayService'
import {logError} from '@/utils/logger'

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const carnet = await createCarnet(body)

    return NextResponse.json({
      message: 'Carnet gerado com sucesso',
      data: carnet,
    })
  } catch (error: unknown) {
    if (error instanceof Error) {
      logError('Erro ao gerar o Carnet:', error.message)

      return NextResponse.json(
        {message: 'Erro ao gerar o Carnet', error: error.message},
        {status: 500},
      )
    } else {
      logError('Erro desconhecido:', error)
    }
  }
}
