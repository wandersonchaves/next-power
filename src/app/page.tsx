'use client'

import CustomersPage from './customers/page'
import ImportPage from './import/page'

import {useCustomers} from '@/hooks/useCustomers'

const Home = () => {
  const {customers, loading} = useCustomers()

  if (loading) {
    return (
      <section className="container mt-10 flex flex-col items-center gap-3 text-center md:absolute md:left-1/2 md:top-1/2 md:mt-0 md:-translate-x-1/2 md:-translate-y-1/2">
        <p>Carregando...</p>
      </section>
    )
  }

  return (
    <section className="container mt-10 flex flex-col items-center gap-3 text-center md:absolute md:left-1/2 md:top-1/2 md:mt-0 md:-translate-x-1/2 md:-translate-y-1/2">
      {customers.length > 0 ? <CustomersPage /> : <ImportPage />}
    </section>
  )
}

export default Home
