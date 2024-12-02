import {NextApiRequest, NextApiResponse} from 'next'

import {createCarnet} from '@/services/gerencianet'

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  if (req.method !== 'POST') {
    return res.status(405).json({message: 'Method not allowed'})
  }

  try {
    const {customer, items} = req.body
    const carnet = await createCarnet({customer, items})

    res.status(200).json({message: 'Carnet created', carnet})
  } catch (error) {
    console.error('Error creating carnet:', error)
    res.status(500).json({message: 'Error creating carnet', error})
  }
}
