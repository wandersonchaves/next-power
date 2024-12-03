'use client'

import React, {useState} from 'react'
import {toast} from 'react-hot-toast'

import FileUpload from '@/components/FileUpload'
import {logError} from '@/utils/logger'

const ImportPage: React.FC = () => {
  const [loading, setLoading] = useState(false)

  const handleFileUpload = async (file: File) => {
    setLoading(true)
    const formData = new FormData()
    formData.append('file', file)

    try {
      const response = await fetch('/api/upload', {
        method: 'POST',
        body: formData,
      })

      if (response.ok) {
        console.log('Upload realizado com sucesso!')
      } else {
        logError('Erro no upload:', await response.json())
      }
    } catch (error) {
      logError('Erro ao importar:', error)
      toast.error('Erro ao processar o arquivo.')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="container mx-auto p-4">
      <h1 className="mb-4 text-2xl font-bold">Importar Arquivo Excel</h1>
      <FileUpload
        onFileUpload={handleFileUpload}
        loading={loading}
      />
    </div>
  )
}

export default ImportPage
