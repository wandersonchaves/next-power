'use client'

import {useState} from 'react'
import {useRouter} from 'next/navigation'

const NewCustomer = () => {
  const router = useRouter()

  const [formData, setFormData] = useState({
    name: '',
    cpf: '',
    birthDate: '',
    phone: '',
    email: '',
    address: '',
    postalCode: '',
    spouseName: '',
  })

  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const {name, value} = e.target
    setFormData({...formData, [name]: value})
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault()
    setLoading(true)
    setError(null)

    try {
      const response = await fetch('/api/customers', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(formData),
      })

      if (!response.ok) {
        const errorData = await response.json()
        throw new Error(errorData.message || 'Erro desconhecido.')
      }

      await response.json()
      router.push('/customers')
    } catch (err: unknown) {
      if (err instanceof Error) {
        setError(err.message)
      } else {
        setError('Erro desconhecido.')
      }
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="container mx-auto p-6">
      <h1 className="mb-4 text-2xl font-bold">CADASTRAR NOVO INSCRITO</h1>
      <form
        onSubmit={handleSubmit}
        className="space-y-4"
      >
        <div className="mb-6 grid gap-6 md:grid-cols-2">
          <div>
            <label
              htmlFor="name"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              Nome
            </label>
            <input
              type="text"
              name="name"
              placeholder="Ex.: João da Silva"
              value={formData.name}
              onChange={handleChange}
              required
              className="block w-full rounded-lg border border-gray-300 bg-gray-50 p-2.5 text-sm text-gray-900 focus:border-blue-500 focus:ring-blue-500 dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:placeholder:text-gray-400 dark:focus:border-blue-500 dark:focus:ring-blue-500"
            />
          </div>
          <div>
            <label
              htmlFor="cpf"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              CPF
            </label>
            <input
              type="text"
              name="cpf"
              placeholder="Ex.: 123.456.789-00"
              value={formData.cpf}
              onChange={handleChange}
              required
              className="w-full rounded border p-2"
            />
          </div>
          <div>
            <label
              htmlFor="birthDate"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              Data de Nascimento
            </label>
            <input
              type="date"
              name="birthDate"
              value={formData.birthDate}
              onChange={handleChange}
              className="w-full rounded border p-2"
            />
          </div>
          <div>
            <label
              htmlFor="phone"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              Telefone
            </label>
            <input
              type="text"
              name="phone"
              placeholder="Ex.: (86) 99999-9999"
              value={formData.phone}
              onChange={handleChange}
              className="w-full rounded border p-2"
            />
          </div>
          <div>
            <label
              htmlFor="email"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              Email
            </label>
            <input
              type="email"
              name="email"
              placeholder="Ex.: joao.silva@email.com"
              value={formData.email}
              onChange={handleChange}
              className="w-full rounded border p-2"
            />
          </div>
          <div>
            <label
              htmlFor="address"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              Endereço
            </label>
            <input
              type="text"
              name="address"
              placeholder="Ex.: Rua das Flores, 123"
              value={formData.address}
              onChange={handleChange}
              className="w-full rounded border p-2"
            />
          </div>
          <div>
            <label
              htmlFor="cep"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              CEP
            </label>
            <input
              type="text"
              name="postalCode"
              placeholder="Ex.: 64000-000"
              value={formData.postalCode}
              onChange={handleChange}
              className="w-full rounded border p-2"
            />
          </div>
          <div>
            <label
              htmlFor="spouseName"
              className="mb-2 block text-sm font-medium text-gray-900 dark:text-white"
            >
              Nome do Cônjuge (opcional)
            </label>
            <input
              type="text"
              name="spouseName"
              placeholder="Ex.: Maria da Silva"
              value={formData.spouseName}
              onChange={handleChange}
              className="w-full rounded border p-2"
            />
          </div>
          <div>{error && <p className="text-red-500">{error}</p>}</div>
        </div>
        <button
          type="submit"
          disabled={loading}
          className="w-full rounded-lg bg-blue-700 px-5 py-2.5 text-center text-sm font-medium text-white hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-blue-300 sm:w-auto dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
        >
          {loading ? 'Cadastrando...' : 'Cadastrar'}
        </button>
      </form>
    </div>
  )
}

export default NewCustomer
