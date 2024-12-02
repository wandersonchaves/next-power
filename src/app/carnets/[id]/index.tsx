import React, {useEffect, useState} from 'react'
import {useRouter} from 'next/router'

import CarnetDetails from '@/components/CarnetDetails'

const CarnetDetailsPage: React.FC = () => {
  const router = useRouter()
  const {id} = router.query
  const [carnet, setCarnet] = useState(null)

  useEffect(() => {
    if (id) {
      const fetchCarnetDetails = async () => {
        const response = await fetch(`/api/carnets/${id}`)
        const data = await response.json()
        setCarnet(data)
      }

      fetchCarnetDetails()
    }
  }, [id])

  return (
    <div className="container mx-auto p-4">
      {carnet ? <CarnetDetails carnet={carnet} /> : <p>Carregando...</p>}
    </div>
  )
}

export default CarnetDetailsPage
