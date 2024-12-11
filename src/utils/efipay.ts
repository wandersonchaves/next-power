import axios from 'axios'

const API_BASE_URL =
  process.env.EFI_API_BASE_URL ?? 'https://cobrancas-h.api.efipay.com.br/v1'

let cachedAccessToken: string | null = null
let cachedTokenExpiry: number | null = null

export async function getAuthorizationToken(): Promise<string> {
  try {
    if (
      cachedAccessToken &&
      cachedTokenExpiry &&
      Date.now() < cachedTokenExpiry
    ) {
      return cachedAccessToken
    }

    const clientId = process.env.EFI_CLIENT_ID
    const clientSecret = process.env.EFI_CLIENT_SECRET

    if (!clientId || !clientSecret) {
      console.error('Client ID ou Client Secret não estão configurados.')
      throw new Error('Configuração de autenticação está incompleta.')
    }

    const authData = {
      grant_type: 'client_credentials',
    }

    const authHeader = `Basic ${Buffer.from(`${clientId}:${clientSecret}`).toString('base64')}`

    const response = await axios.post(`${API_BASE_URL}/authorize`, authData, {
      headers: {
        Authorization: authHeader,
        'Content-Type': 'application/json',
      },
    })

    const {access_token, expires_in} = response.data

    if (!access_token) {
      console.error('Resposta inesperada ao buscar token:', response.data)
      throw new Error('Token de autorização não encontrado.')
    }

    cachedAccessToken = access_token
    cachedTokenExpiry = Date.now() + expires_in * 1000

    return access_token
  } catch (error: unknown) {
    console.error('Erro ao buscar token de autorização:', error)
    if (axios.isAxiosError(error) && error.response) {
      console.error('Detalhes do erro da API:', error.response.data)
    }
    throw new Error('Não foi possível autenticar na API da Efipay.')
  }
}

export const cancelCarnet = async (
  carnetId: string,
  token: string,
): Promise<void> => {
  await axios.put(
    `${API_BASE_URL}/carnet/${carnetId}/cancel`,
    {},
    {
      headers: {
        Authorization: `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
    },
  )
}

export const getChargeStatus = async (chargeId: string, token: string) => {
  const response = await axios.get(`${API_BASE_URL}/charge/${chargeId}`, {
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/json',
    },
  })

  return response.data
}
