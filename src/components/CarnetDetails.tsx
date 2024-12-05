import type {Carnet} from '@/types/Carnet'

interface CarnetDetailsProps {
  carnet: Carnet
}

const CarnetDetails: React.FC<CarnetDetailsProps> = ({carnet}) => (
  <div>
    <h2 className="text-2xl font-bold">Detalhes do Carnê</h2>
    <p>
      <strong>Status:</strong> {carnet.status}
    </p>
    <p>
      <strong>Valor Total:</strong> R${(carnet.value / 100).toFixed(2)}
    </p>
    <p>
      <strong>Link:</strong>{' '}
      <a
        href={carnet.link}
        target="_blank"
        rel="noopener noreferrer"
      >
        Visualizar Carnê
      </a>
    </p>

    <h3 className="mt-4 text-xl font-bold">Parcelas</h3>
    <table className="table-auto border-collapse border border-gray-300">
      <thead>
        <tr>
          <th className="border px-4 py-2">Parcela</th>
          <th className="border px-4 py-2">Status</th>
          <th className="border px-4 py-2">Vencimento</th>
          <th className="border px-4 py-2">Link</th>
        </tr>
      </thead>
      <tbody>
        {carnet.charges?.length ? (
          carnet.charges.map((charge) => (
            <tr key={charge.chargeId}>
              <td className="border px-4 py-2">{charge.parcel}</td>
              <td className="border px-4 py-2">{charge.status}</td>
              <td className="border px-4 py-2">
                {new Date(charge.expireAt).toLocaleDateString()}
              </td>
              <td className="border px-4 py-2">
                <a
                  href={charge.url}
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  Visualizar Parcela
                </a>
              </td>
            </tr>
          ))
        ) : (
          <tr>
            <td
              colSpan={4}
              className="border px-4 py-2 text-center"
            >
              Nenhuma parcela encontrada.
            </td>
          </tr>
        )}
      </tbody>{' '}
    </table>
  </div>
)

export default CarnetDetails
