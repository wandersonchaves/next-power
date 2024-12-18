'use client'

import {useEffect, useState} from 'react'

import type {CustomerOutput} from '@/types/Customer'
import {logError} from '@/utils/logger'

interface UseCustomersResult {
  customers: CustomerOutput[]
  loading: boolean
  totalPages: number
  currentPage: number
  setPage: (page: number) => void
}

export const useCustomers = (
  initialPage: number = 1,
  limit: number = 10,
): UseCustomersResult => {
  const [customers, setCustomers] = useState<CustomerOutput[]>([])
  const [loading, setLoading] = useState<boolean>(true)
  const [totalPages, setTotalPages] = useState<number>(1)
  const [currentPage, setCurrentPage] = useState<number>(initialPage)

  useEffect(() => {
    const fetchCustomers = async () => {
      setLoading(true)
      try {
        const response = await fetch(
          `/api/customers?page=${currentPage}&limit=${limit}`,
        )
        const data = await response.json()

        setCustomers(data.customers)
        setTotalPages(data.totalPages)
      } catch (error) {
        logError('Erro ao buscar clientes:', error)
      } finally {
        setLoading(false)
      }
    }

    fetchCustomers()
  }, [currentPage, limit])

  const setPage = (page: number) => {
    if (page > 0 && page <= totalPages) {
      setCurrentPage(page)
    }
  }

  return {customers, loading, totalPages, currentPage, setPage}
}
