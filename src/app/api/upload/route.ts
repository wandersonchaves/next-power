import {NextResponse} from 'next/server'
import * as XLSX from 'xlsx'

import {prisma} from '@/lib/prisma'

type ExcelRow = {
  'Carimbo de data/hora': string
  Pontuação: string
  'NOME COMPLETO': string
  CPF: string
  'DATA DE NASCIMENTO': string
  'TELEFONE/WHATS': string
  'EMAIL DE CONTATO': string
  CEP: string
  ENDEREÇO: string
  'NOME COMPLETO DO CÔNJUGE': string
}

export async function POST(req: Request) {
  try {
    const formData = await req.formData()
    const file = formData.get('file') as File

    if (!file) {
      return NextResponse.json({message: 'File is required'}, {status: 400})
    }

    const buffer = await file.arrayBuffer()
    const workbook = XLSX.read(buffer, {type: 'array'})
    const sheet = workbook.Sheets[workbook.SheetNames[0]]
    const data = XLSX.utils.sheet_to_json(sheet)

    const customers = (data as ExcelRow[]).map((row) => ({
      name: row['NOME COMPLETO'],
      cpf: row['CPF'],
      birthDate: new Date(row['DATA DE NASCIMENTO']),
      phone: row['TELEFONE/WHATS'],
      email: row['EMAIL DE CONTATO'],
      address: row['ENDEREÇO'],
      postalCode: row['CEP'],
      spouseName: row['NOME COMPLETO DO CÔNJUGE'],
      points: parseInt(row['Pontuação'], 10) || 0,
      timestamp: new Date(row['Carimbo de data/hora']),
      userId: 'user-id-placeholder',
    }))

    const result = await prisma.customer.createMany({
      data: customers,
      skipDuplicates: true,
    })

    return NextResponse.json({message: 'Data uploaded successfully', result})
  } catch (error) {
    console.error('Error uploading data:', error)
    return NextResponse.json(
      {message: 'Error uploading data', error},
      {status: 500},
    )
  }
}
