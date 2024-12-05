/**
 * Representa as configurações adicionais de uma parcela do carnê.
 */
export interface ChargeConfigurations {
  interest: number
  fine: number
}

/**
 * Representa uma parcela (charge) do carnê.
 */
export interface CarnetCharge {
  chargeId: string
  status: string
  url: string
  pdf: string
  barcode: string
  pixQrCode: string
  pixQrImage: string
  parcel: number
  value: number
  expireAt: Date
  configurations: ChargeConfigurations
}

/**
 * Representa um item no histórico do carnê.
 */
export interface CarnetHistory {
  message: string
  createdAt: Date
}

/**
 * Representa um carnê.
 */
export interface Carnet {
  carnetId: string
  customerId: string
  status: string
  repeats: number
  value: number
  cover: string
  link: string
  carnetLink?: string
  pdf: {
    carnet: string
    cover: string
  }
  createdAt: Date
  charges: CarnetCharge[]
  history: CarnetHistory[]
}
export interface CarnetResponse {
  carnet_id: number
  status: string
  cover: string
  link: string
  carnetLink: string
  pdf: {
    carnet: string
    cover: string
  }
  repeats: number
  value: number
  charges: ChargeData[]
}

export interface ChargeData {
  charge_id: number
  parcel: string
  status: string
  value: number
  expire_at: string
  url: string
  parcel_link: string
  pdf: {
    charge: string
  }
  barcode: string
  pix: {
    qrcode: string
    qrcode_image: string
  }
}

export interface CustomerData {
  name: string
  cpf: string
  phone_number: string
}
