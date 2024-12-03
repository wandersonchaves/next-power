export const isValidCpf = (cpf: string): boolean => /^[0-9]{11}$/.test(cpf)

export const isValidPhone = (phone: string): boolean =>
  /^[1-9]{2}9?[0-9]{8}$/.test(phone)

export const validateCustomerData = (customer: {
  name: string
  cpf: string
  phone_number: string
}) => {
  if (!customer.name || customer.name.trim().length < 3) {
    throw new Error('Nome do cliente inválido.')
  }
  if (!isValidCpf(customer.cpf)) {
    throw new Error('CPF inválido.')
  }
  if (!isValidPhone(customer.phone_number)) {
    throw new Error('Número de telefone inválido.')
  }
}
