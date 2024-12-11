import {NextRequest, NextResponse} from 'next/server'

import {getAuthorizationToken, getChargeStatus} from '@/utils/efipay'
import {logError} from '@/utils/logger'

export async function GET(
  request: NextRequest,
  context: {params: Promise<{id: string}>},
) {
  try {
    const resolvedParams = await context.params
    const {id: chargeId} = resolvedParams

    if (!chargeId) {
      return NextResponse.json(
        {error: 'O charge_id é obrigatório.'},
        {status: 400},
      )
    }

    const token = await getAuthorizationToken()
    const status = await getChargeStatus(chargeId, token)

    return NextResponse.json({status}, {status: 200})
  } catch (error) {
    logError('Erro ao obter status da parcela:', error)

    const errorMessage =
      error instanceof Error ? error.message : 'Erro desconhecido'

    return NextResponse.json(
      {error: 'Erro ao obter status da parcela.', details: errorMessage},
      {status: 500},
    )
  }
}
