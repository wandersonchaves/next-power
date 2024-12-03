export const logError = (message: string, error: unknown) => {
  if (error instanceof Error) {
    console.error(`${message}: ${error.message}`)
  } else {
    console.error(`${message}:`, error)
  }
}

export const logSuccess = (message: string, data?: unknown) => {
  if (data !== undefined) {
    console.log(message, data)
  } else {
    console.log(message)
  }
}
