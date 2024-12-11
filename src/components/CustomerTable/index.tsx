import {Customer} from '@/types/Customer'
import {sanitizePhoneNumber} from '@/utils/phoneUtils'

const onViewCarnet = (carnetLink: string) => {
  window.open(carnetLink, '_blank')
}

interface CustomerTableProps {
  customers: Customer[]
  onGenerateCarnet: (customer: Customer) => void
  generatingCustomerId: string | null
}

const getCarnetStatusDescription = (status: string): string => {
  switch (status) {
    case 'up_to_date':
      return 'Em dia'
    case 'unpaid':
      return 'Inadimplente'
    case 'finished':
      return 'Finalizado'
    default:
      return 'Desconhecido'
  }
}

const isChargeResolved = (status: string): boolean => {
  const resolvedStatuses = [
    'paid',
    'contested',
    'refunded',
    'settled',
    'canceled',
  ]
  return resolvedStatuses.includes(status)
}

const CustomerTable: React.FC<CustomerTableProps> = ({
  customers,
  onGenerateCarnet,
  generatingCustomerId,
}) => {
  return (
    <div className="relative overflow-x-auto shadow-md sm:rounded-lg">
      <table className="w-full text-left text-sm text-gray-500 rtl:text-right dark:text-gray-400">
        <thead className="bg-gray-50 text-xs uppercase text-gray-700 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th className="px-6 py-3">Nome</th>
            <th className="px-6 py-3">CPF</th>
            <th className="px-6 py-3">Email</th>
            <th className="px-6 py-3">Telefone</th>
            <th className="px-6 py-3">Parcelas</th>
            <th className="px-6 py-3">
              <span className="sr-only">Carnê</span>
            </th>
          </tr>
        </thead>
        <tbody>
          {customers.map((customer) => (
            <tr
              key={customer.id}
              className="border-b bg-white dark:border-gray-700 dark:bg-gray-800"
            >
              <th className="px-6 py-4">{customer.name}</th>
              <td className="px-6 py-4">{customer.cpf}</td>
              <td className="px-6 py-4">{customer.email || 'Não informado'}</td>
              <td className="px-6 py-4">
                {sanitizePhoneNumber(customer.phone || '') ?? (
                  <span className="text-red-500">Telefone inválido</span>
                )}
              </td>
              <td className="px-6 py-4">
                {customer.carnets && customer.carnets.length > 0 ? (
                  <div className="flex flex-wrap gap-2">
                    {customer.carnets[0].charges?.map((charge) => (
                      <span
                        key={charge.chargeId}
                        className={`inline-block rounded px-3 py-1 text-xs font-medium ${
                          isChargeResolved(charge.status)
                            ? 'bg-green-100 text-green-800'
                            : 'bg-red-100 text-red-800'
                        }`}
                      >
                        {charge.parcel}
                      </span>
                    ))}
                  </div>
                ) : (
                  <span className="text-gray-500">Sem parcelas</span>
                )}
              </td>
              <td className="px-6 py-4">
                {customer.carnets && customer.carnets.length > 0 ? (
                  <>
                    <div>
                      <span className="font-medium">
                        Status:{' '}
                        {getCarnetStatusDescription(customer.carnets[0].status)}
                      </span>
                    </div>
                    <button
                      onClick={() =>
                        onViewCarnet(customer.carnets?.[0]?.link ?? '')
                      }
                      className="mt-1 rounded-lg bg-orange-400 px-5 py-2.5 text-sm font-medium text-white hover:bg-orange-500 focus:outline-none focus:ring-4 focus:ring-orange-300"
                    >
                      Ver Carnê
                    </button>
                  </>
                ) : (
                  <button
                    onClick={() => onGenerateCarnet(customer)}
                    disabled={generatingCustomerId === customer.id}
                    className="mb-2 rounded-lg bg-blue-700 px-5 py-2.5 text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300"
                  >
                    {generatingCustomerId === customer.id
                      ? 'Gerando...'
                      : 'Gerar Carnê'}
                  </button>
                )}
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  )
}

export default CustomerTable
