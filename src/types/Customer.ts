export interface Charge {
  chargeId: string
  parcel: number
  status: string
  value: number
  expireAt: Date
}

export interface Carnet {
  id: string
  status: string
  link: string
  charges?: Charge[]
}

export interface Customer {
  id: string
  name: string
  cpf: string
  email: string
  phone: string
  carnetId?: string
  carnetGenerated: boolean
  carnetStatus?: string
  carnetLink?: string
  carnets?: Carnet[]
}
