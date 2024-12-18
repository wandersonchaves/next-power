declare module 'sdk-typescript-apis-efi' {
  interface EfiPayConfig {
    sandbox: boolean
    client_id: string
    client_secret: string
    certificate: string
  }

  export interface EfiPayData {
    carnet_id: number
    status: string
    repeats: number
    value: number
    link: string
    cover: string
    carnetLink?: string
    created_at: string
    charges: Array<{
      charge_id: number
      parcel: number
      status: string
      value: number
      expire_at: string
      url: string
      parcel_link: string
    }>
  }

  interface EfiPayResponse {
    code: number
    data: EfiPayData
  }

  interface ChargeItem {
    name: string
    value: number
    amount: number
  }

  interface Customer {
    name: string
    cpf: string
    phone_number: string
  }

  interface CreateChargeBody {
    items: ChargeItem[]
    customer: Customer
    expire_at: string
    repeats: number
    split_items?: boolean
    message?: string
  }

  export default class EfiPay {
    constructor(config: EfiPayConfig)
    createCarnet(
      params: object,
      body: CreateChargeBody,
    ): Promise<EfiPayResponse>
  }
}
