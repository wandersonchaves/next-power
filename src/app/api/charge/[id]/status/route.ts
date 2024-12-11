import axios from 'axios'
import {NextResponse} from 'next/server'

import {getAuthorizationToken} from '@/utils/efipay'

const API_BASE_URL =
  process.env.EFI_API_BASE_URL ?? 'https://cobrancas-h.api.efipay.com.br/v1'

export async function GET(request: Request, {params}: {params: {id: string}}) {
  const {id: chargeId} = params

  if (!chargeId) {
    return NextResponse.json(
      {error: 'O charge_id é obrigatório.'},
      {status: 400},
    )
  }

  try {
    const token = await getAuthorizationToken()
    const response = await axios.get(`${API_BASE_URL}/charge/${chargeId}`, {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    })

    return NextResponse.json(response.data, {status: 200})
  } catch (error: unknown) {
    console.error(`Erro ao buscar status para charge ID ${chargeId}:`, error)

    if (axios.isAxiosError(error)) {
      if (error.response?.status === 404) {
        return NextResponse.json(
          {error: `Charge ID ${chargeId} não encontrado.`},
          {status: 404},
        )
      }

      return NextResponse.json(
        {
          error: 'Erro ao buscar status do charge.',
          details: error.response?.data || error.message,
        },
        {status: error.response?.status || 500},
      )
    }

    return NextResponse.json(
      {error: 'Erro desconhecido ao buscar status do charge.'},
      {status: 500},
    )
  }
}
