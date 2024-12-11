import {NextResponse} from 'next/server'

import {cancelCarnet, getAuthorizationToken} from '@/utils/efipay'
import {logError} from '@/utils/logger'

export async function PUT(request: Request, {params}: {params: {id: string}}) {
  const {id: carnetId} = params

  try {
    if (!carnetId) {
      return NextResponse.json(
        {error: 'O carnet_id é obrigatório.'},
        {status: 400},
      )
    }

    const token = await getAuthorizationToken()
    await cancelCarnet(carnetId, token)

    return NextResponse.json(
      {message: 'Carnê cancelado com sucesso.'},
      {status: 200},
    )
  } catch (error) {
    logError('Erro ao cancelar o carnê:', error)
    return NextResponse.json(
      {error: 'Erro ao cancelar o carnê.', details: error},
      {status: 500},
    )
  }
}
