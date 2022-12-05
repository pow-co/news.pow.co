import '../styles/globals.css'
import '../styles/app.css'
import type { AppProps } from 'next/app'
import { WalletProvider as AuthProvider } from '../contexts/WalletContext';

export default function App({ Component, pageProps }: AppProps) {
  return (
    <AuthProvider>
      <Component {...pageProps} />
    </AuthProvider>
  )
}
