const efiConfig = {
  sandbox: false,
  client_id: process.env.EFI_CLIENT_ID ?? '',
  client_secret: process.env.EFI_CLIENT_SECRET ?? '',
  certificate: process.env.EFI_PIX_CERT ?? '',
}

export default efiConfig
