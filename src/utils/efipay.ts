import axios from 'axios'

const API_BASE_URL =
  process.env.EFI_API_BASE_URL ?? 'https://cobrancas-h.api.efipay.com.br/v1'

export const getAuthorizationToken = async (): Promise<string> => {
  const credentials = Buffer.from(
    `${process.env.EFI_CLIENT_ID}:${process.env.EFI_CLIENT_SECRET}`,
  ).toString('base64')

  const response = await axios.post(
    `${API_BASE_URL}/authorize`,
    {grant_type: 'client_credentials'},
    {
      headers: {
        Authorization: `Basic ${credentials}`,
        'Content-Type': 'application/json',
      },
    },
  )

  return response.data.access_token
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
