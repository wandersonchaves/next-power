export interface ChargeInput {
  carnetId: string
  chargeId: string
  status: string
  url: string
  parcel: number
  value: number
}

export interface ChargeOutput {
  chargeId: string
  status: string
  url: string
  parcel: number
  value: number
  expireAt: Date
}
