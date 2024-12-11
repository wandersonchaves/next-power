const efiConfig = {
  sandbox: process.env.NODE_ENV !== 'production',
  client_id: process.env.EFI_CLIENT_ID ?? '',
  client_secret: process.env.EFI_CLIENT_SECRET ?? '',
  certificate: process.env.EFI_PIX_CERT ?? '',
}

export default efiConfig
