import React from 'react'

interface Carnet {
  id: string
  customerName: string
  totalValue: number
  createdAt: string
}

const CarnetDetails: React.FC<{carnet: Carnet}> = ({carnet}) => {
  return (
    <div>
      <h1 className="mb-4 text-2xl font-bold">Detalhes do Carnê</h1>
      <p>
        <strong>ID:</strong> {carnet.id}
      </p>
      <p>
        <strong>Cliente:</strong> {carnet.customerName}
      </p>
      <p>
        <strong>Valor Total:</strong> {carnet.totalValue}
      </p>
      <p>
        <strong>Data de Criação:</strong>{' '}
        {new Date(carnet.createdAt).toLocaleDateString()}
      </p>
    </div>
  )
}

export default CarnetDetails
