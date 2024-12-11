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
              <td className="px-6 py-4">{customer.email ?? 'Não informado'}</td>
              <td className="px-6 py-4">
                {customer.phone ? (
                  sanitizePhoneNumber(customer.phone)
                ) : (
                  <span className="text-red-500">Telefone inválido</span>
                )}
              </td>{' '}
              <td className="px-6 py-4">
                {customer.carnets && customer.carnets.length > 0 ? (
                  customer.carnets[0]?.charges &&
                  customer.carnets[0].charges.length > 0 ? (
                    <div className="flex flex-wrap gap-1">
                      {customer.carnets[0].charges.map((charge, index) => (
                        <span
                          key={`charge-${charge.chargeId}-${index}`}
                          className={`inline-block rounded px-2 py-1 text-sm font-medium ${
                            charge.status === 'paid'
                              ? 'bg-green-200 text-green-700'
                              : 'bg-gray-200 text-gray-700'
                          }`}
                        >
                          {charge.parcel}
                        </span>
                      ))}
                    </div>
                  ) : (
                    <span>Sem parcelas</span>
                  )
                ) : (
                  <span>Sem carnês</span>
                )}
              </td>
              <td className="px-6 py-4 text-right">
                {customer.carnets && customer.carnets.length > 0 ? (
                  <button
                    onClick={() =>
                      onViewCarnet(customer.carnets?.[0]?.link ?? '')
                    }
                    className="mb-2 me-2 rounded-lg bg-orange-400 px-5 py-2.5 text-sm font-medium text-white hover:bg-orange-500 focus:outline-none focus:ring-4 focus:ring-orange-300 dark:bg-orange-600 dark:hover:bg-orange-700 dark:focus:ring-orange-800"
                  >
                    Ver Carnê
                  </button>
                ) : (
                  <button
                    onClick={() => onGenerateCarnet(customer)}
                    disabled={generatingCustomerId === customer.id}
                    className="mb-2 me-2 rounded-lg bg-blue-700 px-5 py-2.5 text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
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
