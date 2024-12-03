'use client'

import React, {useState} from 'react'

import CustomerTable from '@/components/CustomerTable'
import Pagination from '@/components/Pagination'
import {
  DEFAULT_MESSAGE,
  EXPIRATION_DATE,
  INSTALLMENT_VALUE,
  INSTALLMENTS,
  TRAVEL_SERVICE_NAME,
} from '@/config/constants'
import {useCustomers} from '@/hooks/useCustomers'
import {logError} from '@/utils/logger'
import {sanitizePhoneNumber} from '@/utils/phoneUtils'

const CustomersPage = () => {
  const {customers, loading, totalPages, currentPage, setPage} = useCustomers()
  const [generatingCustomerId, setGeneratingCustomerId] = useState<
    string | null
  >(null)

  const handleGenerateCarnet = async (customer: {
    id: string
    name: string
    cpf: string
    phone: string
  }) => {
    const sanitizedPhone = sanitizePhoneNumber(customer.phone)

    if (!sanitizedPhone) {
      alert(`Número de telefone inválido para o cliente: ${customer.name}`)
      console.error(`Telefone inválido: ${customer.phone}`)
      return
    }

    try {
      setGeneratingCustomerId(customer.id)

      const response = await fetch('/api/carnet', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({
          items: [
            {name: TRAVEL_SERVICE_NAME, value: INSTALLMENT_VALUE, amount: 1},
          ],
          customer: {
            name: customer.name,
            cpf: customer.cpf,
            phone_number: sanitizedPhone,
          },
          expire_at: EXPIRATION_DATE,
          repeats: INSTALLMENTS,
          message: DEFAULT_MESSAGE,
        }),
      })

      if (!response.ok) throw new Error('Erro ao gerar o carnê')

      const data = await response.json()
      alert('Carnê gerado com sucesso!')
      console.log('Resposta do servidor:', data)
    } catch (error) {
      alert('Erro ao gerar o carnê')
      logError('Erro ao gerar o carnê:', error)
    } finally {
      setGeneratingCustomerId(null)
    }
  }

  if (loading) {
    return <p>Carregando clientes...</p>
  }

  return (
    <div className="p-6">
      <h1 className="mb-4 text-xl font-bold">Lista de Clientes</h1>
      <CustomerTable
        customers={customers}
        onGenerateCarnet={handleGenerateCarnet}
        generatingCustomerId={generatingCustomerId}
      />
      <Pagination
        currentPage={currentPage}
        totalPages={totalPages}
        onPageChange={setPage}
      />
    </div>
  )
}

export default CustomersPage
