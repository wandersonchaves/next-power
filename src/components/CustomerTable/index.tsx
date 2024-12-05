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
    <div className="overflow-x-auto">
      <table className="min-w-full border border-gray-200 bg-white">
        <thead>
          <tr className="bg-gray-100 text-left">
            <th className="border px-4 py-2">Nome</th>
            <th className="border px-4 py-2">CPF</th>
            <th className="border px-4 py-2">Email</th>
            <th className="border px-4 py-2">Telefone</th>
            <th className="border px-4 py-2">Carnê</th>
          </tr>
        </thead>
        <tbody>
          {customers.map((customer) => (
            <tr
              key={customer.id}
              className="hover:bg-gray-50"
            >
              <td className="border px-4 py-2">{customer.name}</td>
              <td className="border px-4 py-2">{customer.cpf}</td>
              <td className="border px-4 py-2">
                {customer.email || 'Não informado'}
              </td>
              <td className="border px-4 py-2">
                {sanitizePhoneNumber(customer.phone) ?? (
                  <span className="text-red-500">Telefone inválido</span>
                )}
              </td>
              <td className="border px-4 py-2">
                {customer.carnets && customer.carnets.length > 0 ? (
                  <>
                    <p>
                      Status: {customer.carnets[0].status || 'Indisponível'}
                    </p>
                    <button
                      onClick={() =>
                        onViewCarnet(customer.carnets?.[0]?.link ?? '')
                      }
                      className="text-sm text-blue-500 hover:underline"
                    >
                      Ver Carnê
                    </button>
                  </>
                ) : (
                  <button
                    onClick={() => onGenerateCarnet(customer)}
                    disabled={generatingCustomerId === customer.id}
                    className="rounded bg-blue-500 px-4 py-2 text-sm text-white hover:bg-blue-600 disabled:bg-gray-400"
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
