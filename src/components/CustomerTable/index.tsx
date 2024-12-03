import React from 'react'

import {Button} from '../ui/button'

import {sanitizePhoneNumber} from '@/utils/phoneUtils'

interface Customer {
  id: string
  name: string
  cpf: string
  email: string
  phone: string
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
}) => (
  <div className="overflow-x-auto">
    <table className="min-w-full border border-gray-200 bg-white">
      <thead>
        <tr className="bg-gray-100 text-left">
          <th className="border px-4 py-2">Nome</th>
          <th className="border px-4 py-2">CPF</th>
          <th className="border px-4 py-2">Email</th>
          <th className="border px-4 py-2">Telefone</th>
          <th className="border px-4 py-2">Ações</th>
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
              {sanitizePhoneNumber(customer.phone) || (
                <span className="text-red-500">Telefone inválido</span>
              )}
            </td>
            <td className="border px-4 py-2">
              <Button
                label={
                  generatingCustomerId === customer.id
                    ? 'Gerando...'
                    : 'Gerar Carnê'
                }
                onClick={() => onGenerateCarnet(customer)}
                className="text-sm"
                disabled={generatingCustomerId === customer.id}
              />
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  </div>
)

export default CustomerTable
