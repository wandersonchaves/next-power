import Gerencianet from 'gn-api-sdk-typescript'

const options = {
  client_id: process.env.GN_CLIENT_ID!,
  client_secret: process.env.GN_CLIENT_SECRET!,
  sandbox: true,
}

const gn = new Gerencianet(options)

export const createCarnet = async ({
  customer,
  items,
}: {
  customer: {
    name: string
    cpf: string
    phone_number: string
    email: string
  }
  items: Array<{name: string; value: number}>
}) => {
  const carnetData = {
    customer,
    items,
    repeats: 12,
    split_items: false,
  }

  return gn.createCarnet({}, carnetData)
}
