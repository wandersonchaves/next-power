export const sanitizePhoneNumber = (phone: string): string | null => {
  const sanitized = phone.replace(/\D/g, '')

  const isValid = /^[1-9]{2}9?[0-9]{8}$/.test(sanitized)

  return isValid ? sanitized : null
}
