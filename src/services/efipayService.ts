import EfiPay from 'sdk-typescript-apis-efi'

import efiConfig from '@/config/efiConfig'
import {logError} from '@/utils/logger'
import {sanitizePhoneNumber} from '@/utils/phoneUtils'

const efipay = new EfiPay(efiConfig)

export const createCarnet = async (body: {
  items: {name: string; value: number; amount: number}[]
  customer: {name: string; cpf: string; phone_number: string}
  expire_at: string
  repeats: number
  split_items?: boolean
  configurations?: {fine?: number; interest?: number}
  message?: string
}) => {
  const sanitizedPhone = sanitizePhoneNumber(body.customer.phone_number)

  if (!sanitizedPhone) {
    throw new Error('Número de telefone inválido.')
  }

  try {
    const response = await efipay.createCarnet(
      {},
      {...body, customer: {...body.customer, phone_number: sanitizedPhone}},
    )
    console.log('Carnê criado com sucesso:', response)
    return response
  } catch (error: unknown) {
    logError('Erro ao criar o Carnê:', error)
    throw new Error('Erro ao criar o Carnê')
  }
}
