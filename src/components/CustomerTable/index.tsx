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
            <th
              scope="col"
              className="px-6 py-3"
            >
              Nome
            </th>
            <th
              scope="col"
              className="px-6 py-3"
            >
              <div className="flex items-center">CPF</div>
            </th>
            <th
              scope="col"
              className="px-6 py-3"
            >
              <div className="flex items-center">Email</div>
            </th>
            <th
              scope="col"
              className="px-6 py-3"
            >
              <div className="flex items-center">Telefone</div>
            </th>
            <th
              scope="col"
              className="px-6 py-3"
            >
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
                {sanitizePhoneNumber(customer.phone) ?? (
                  <span className="text-red-500">Telefone inválido</span>
                )}
              </td>
              <td className="px-6 py-4 text-right">
                {customer.carnets && customer.carnets.length > 0 ? (
                  <>
                    <button
                      onClick={() =>
                        onViewCarnet(customer.carnets?.[0]?.link ?? '')
                      }
                      className="mb-2 me-2 rounded-lg bg-orange-400 px-5 py-2.5 text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                    >
                      Ver Carnê
                    </button>
                  </>
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
