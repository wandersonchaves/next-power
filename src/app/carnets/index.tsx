import React, {useEffect, useState} from 'react'
import {useRouter} from 'next/router'

import CarnetTable from '@/components/CarnetTable'

const CarnetsPage: React.FC = () => {
  const [carnets, setCarnets] = useState([])
  const router = useRouter()

  useEffect(() => {
    const fetchCarnets = async () => {
      const response = await fetch('/api/carnets')
      const data = await response.json()
      setCarnets(data)
    }

    fetchCarnets()
  }, [])

  return (
    <div className="container mx-auto p-4">
      <h1 className="mb-4 text-2xl font-bold">Carnês</h1>
      <CarnetTable
        carnets={carnets}
        onViewDetails={(id) => router.push(`/carnets/${id}`)}
      />
    </div>
  )
}

export default CarnetsPage
