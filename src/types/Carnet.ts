import type {ChargeOutput} from './Charge'

export interface CarnetInput {
  customerId: string
  carnetId: string
  status: string
  repeats: number
  value: number
  cover?: string
  link: string
  carnetLink?: string
}

export interface CarnetOutput {
  customerId: string
  carnetId: string
  status: string
  repeats: number
  value: number
  cover: string
  link: string
  carnetLink?: string
  charges: ChargeOutput[]
}
