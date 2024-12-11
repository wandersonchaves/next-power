import {NextRequest, NextResponse} from 'next/server'

import {getAuthorizationToken, getChargeStatus} from '@/utils/efipay'
import {logError} from '@/utils/logger'

export async function GET(
  request: NextRequest,
  context: {params: {id: string}},
) {
  const {id: chargeId} = context.params

  if (!chargeId) {
    return NextResponse.json(
      {error: 'O charge_id é obrigatório.'},
      {status: 400},
    )
  }

  try {
    const token = await getAuthorizationToken()
    const status = await getChargeStatus(chargeId, token)

    return NextResponse.json({status}, {status: 200})
  } catch (error) {
    logError('Erro ao obter status da parcela:', error)
    return NextResponse.json(
      {error: 'Erro ao obter status da parcela.', details: error},
      {status: 500},
    )
  }
}
