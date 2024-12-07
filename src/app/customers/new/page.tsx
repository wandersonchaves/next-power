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

      const data = await response.json()
      alert(data.message)
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
      <h1 className="mb-4 text-2xl font-bold">Cadastrar Novo Cliente</h1>
      <form
        onSubmit={handleSubmit}
        className="space-y-4"
      >
        <input
          type="text"
          name="name"
          placeholder="Nome"
          value={formData.name}
          onChange={handleChange}
          required
          className="w-full rounded border p-2"
        />
        <input
          type="text"
          name="cpf"
          placeholder="CPF"
          value={formData.cpf}
          onChange={handleChange}
          required
          className="w-full rounded border p-2"
        />
        <input
          type="date"
          name="birthDate"
          value={formData.birthDate}
          onChange={handleChange}
          className="w-full rounded border p-2"
        />
        <input
          type="text"
          name="phone"
          placeholder="Telefone"
          value={formData.phone}
          onChange={handleChange}
          className="w-full rounded border p-2"
        />
        <input
          type="email"
          name="email"
          placeholder="Email"
          value={formData.email}
          onChange={handleChange}
          className="w-full rounded border p-2"
        />
        <input
          type="text"
          name="address"
          placeholder="Endereço"
          value={formData.address}
          onChange={handleChange}
          className="w-full rounded border p-2"
        />
        <input
          type="text"
          name="postalCode"
          placeholder="CEP"
          value={formData.postalCode}
          onChange={handleChange}
          className="w-full rounded border p-2"
        />
        <input
          type="text"
          name="spouseName"
          placeholder="Nome do Cônjuge"
          value={formData.spouseName}
          onChange={handleChange}
          className="w-full rounded border p-2"
        />
        {error && <p className="text-red-500">{error}</p>}
        <button
          type="submit"
          disabled={loading}
          className="rounded bg-blue-500 px-4 py-2 text-white hover:bg-blue-600 disabled:bg-gray-300"
        >
          {loading ? 'Cadastrando...' : 'Cadastrar'}
        </button>
      </form>
    </div>
  )
}

export default NewCustomer
