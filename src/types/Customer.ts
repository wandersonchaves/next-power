import type {CarnetOutput} from './Carnet'

export interface CustomerInput {
  name: string
  cpf: string
  birthDate?: Date
  phone?: string
  email?: string
  address?: string
  postalCode?: string
  spouseName?: string
  status?: string
  carnetGenerated?: boolean
  userId: string
}

export interface CustomerOutput {
  id: string
  name: string
  cpf: string
  birthDate?: Date
  phone?: string
  email?: string
  address?: string
  postalCode?: string
  spouseName?: string
  status: string
  carnetGenerated: boolean

  userId: string
  carnets: CarnetOutput[]
}

export interface CustomerData {
  name: string
  cpf: string
  phone_number: string
}
