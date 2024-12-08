import React from 'react'

interface Carnet {
  id: string
  customerName: string
  totalValue: number
  createdAt: string
}

interface CarnetTableProps {
  carnets: Carnet[]
  onViewDetails: (id: string) => void
}

const CarnetTable: React.FC<CarnetTableProps> = ({carnets, onViewDetails}) => {
  return (
    <table className="w-full border-collapse border border-gray-300">
      <thead>
        <tr>
          <th className="border border-gray-300 p-2">ID</th>
          <th className="border border-gray-300 p-2">Inscrito</th>
          <th className="border border-gray-300 p-2">Valor Total</th>
          <th className="border border-gray-300 p-2">Data de Criação</th>
          <th className="border border-gray-300 p-2">Ações</th>
        </tr>
      </thead>
      <tbody>
        {carnets.map((carnet) => (
          <tr key={carnet.id}>
            <td className="border border-gray-300 p-2">{carnet.id}</td>
            <td className="border border-gray-300 p-2">
              {carnet.customerName}
            </td>
            <td className="border border-gray-300 p-2">{carnet.totalValue}</td>
            <td className="border border-gray-300 p-2">
              {new Date(carnet.createdAt).toLocaleDateString()}
            </td>
            <td className="border border-gray-300 p-2">
              <button
                onClick={() => onViewDetails(carnet.id)}
                className="rounded bg-blue-600 px-4 py-2 text-white"
              >
                Detalhes
              </button>
            </td>
          </tr>
        ))}
      </tbody>
    </table>
  )
}

export default CarnetTable
