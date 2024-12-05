import {NextResponse} from 'next/server'

import {saveCarnetData} from '@/services/carnetService'
import {createCarnet} from '@/services/efipayService'
import {logError} from '@/utils/logger'
import {mapEfiPayDataToCarnet} from '@/utils/mappers'

export async function POST(req: Request) {
  try {
    const body = await req.json()
    const carnetResponse = await createCarnet(body)

    const carnet = mapEfiPayDataToCarnet(carnetResponse.data, body.customerId)

    await saveCarnetData(carnet, body.customer)

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
    }

    logError('Erro desconhecido:', error)
    return NextResponse.json(
      {message: 'Erro desconhecido ao gerar o Carnet'},
      {status: 500},
    )
  }
}
