import {EfiPayData} from 'sdk-typescript-apis-efi'

import {Carnet, CarnetCharge} from '@/types/Carnet'

export const mapEfiPayDataToCarnet = (
  data: EfiPayData,
  customerId: string,
): Carnet => {
  const charges = Array.isArray(data.charges)
    ? data.charges.map<CarnetCharge>((charge) => ({
        chargeId: charge.charge_id?.toString() || '',
        parcel:
          typeof charge.parcel === 'number'
            ? charge.parcel
            : Number(charge.parcel),
        status: charge.status || 'unknown',
        value: charge.value || 0,
        expireAt: charge.expire_at ? new Date(charge.expire_at) : new Date(),
        url: charge.url || '#',
        parcelLink: charge.parcel_link || '#',
        pdf: charge.pdf?.charge || '',
        barcode: charge.barcode || '',
        pixQrCode: charge.pix?.qrcode || '',
        pixQrImage: charge.pix?.qrcode_image || '',
        configurations: {
          interest: charge.configurations?.interest || 0,
          fine: charge.configurations?.fine || 0,
        },
      }))
    : []

  return {
    carnetId: data.carnet_id?.toString() || '',
    customerId,
    status: data.status || 'unknown',
    repeats: data.repeats || 0,
    value: data.value || 0,
    cover: data.pdf?.cover || '',
    link: data.link || '#',
    carnetLink: data.carnetLink ?? '#',
    pdf: data.pdf || {},
    createdAt: data.created_at ? new Date(data.created_at) : new Date(),
    history: Array.isArray(data.history)
      ? data.history.map((item) => ({
          message: item.message || '',
          createdAt: item.created_at ? new Date(item.created_at) : new Date(),
        }))
      : [],
    charges,
  }
}
