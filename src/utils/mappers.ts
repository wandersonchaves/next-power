import {EfiPayData} from 'sdk-typescript-apis-efi'

import type {CarnetOutput} from '@/types/Carnet'
import type {ChargeOutput} from '@/types/Charge'

export const mapEfiPayDataToCarnet = (
  data: EfiPayData,
  customerId: string,
): CarnetOutput => {
  const charges = Array.isArray(data.charges)
    ? data.charges.map<ChargeOutput>((charge) => ({
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
      }))
    : []

  return {
    carnetId: data.carnet_id?.toString() || '',
    customerId,
    status: data.status || 'unknown',
    repeats: data.repeats || 0,
    value: data.value || 0,
    cover: data.cover || '',
    link: data.link || '#',
    carnetLink: data.carnetLink ?? '#',
    charges,
  }
}
