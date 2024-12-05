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
  carnets?: Array<{
    id: string
    status: string
    link: string
  }>
}
