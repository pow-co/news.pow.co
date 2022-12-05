
import PropTypes from 'prop-types';
import { createContext, useEffect, useReducer } from 'react';

// reducer - state management
import { LOGIN, LOGOUT } from '../store/actions';
import accountReducer from '../store/accountReducer';

// project imports
import axios from 'axios';

import { useSnackbar } from 'notistack';
// constant
const initialState = {
  isLoggedIn: false,
  isInitialized: false,
  user: null,
  wallet: ''
};

const setSession = (serviceToken: any) => {
  if (serviceToken) {
    localStorage.setItem('serviceToken', serviceToken);
    axios.defaults.headers.common.Authorization = `Bearer ${serviceToken}`;
  } else {
    localStorage.removeItem('serviceToken');
    delete axios.defaults.headers.common.Authorization;
  }
};

// ==============================|| JWT CONTEXT & PROVIDER ||============================== //
const WalletContext = createContext(null);

export const WalletProvider = ({ children }: {children: any}) => {

    const [state, dispatch] = useReducer(accountReducer, initialState);

    //const { enqueueSnackbar } = useSnackbar();
  
    useEffect(() => {
      const init = async () => {
        switch (localStorage.getItem('auth.type')) {
          case 'relayx':
            let relayAuth = window.localStorage.getItem('relayx.auth');
            let paymail = window.localStorage.getItem('relayx.paymail');
            let name = window.localStorage.getItem('relayx.paymail');
            let pubkey = window.localStorage.getItem('relayx.pubkey');
            console.log('RELAY AUTH', relayAuth);
  
            if (relayAuth) {
              console.log('DISPATCH', {
                type: LOGIN,
                payload: {
                  wallet: 'relayx',
                  isLoggedIn: true,
                  user: {
                    email: paymail,
                    id: pubkey,
                    name: paymail
                  }
                }
              });
  
              dispatch({
                type: LOGIN,
                payload: {
                  wallet: 'relayx',
                  isLoggedIn: true,
                  user: {
                    email: paymail,
                    id: pubkey,
                    name: paymail
                  }
                }
              });
            } else {
              dispatch({
                type: LOGOUT
              });
            }
            break;
  
          default:
            dispatch({
              type: LOGOUT
            });
        }
      };
  
      init();
    }, []);
  
    const relayxSignIn = async () => {
      //@ts-ignore
      const token = await relayone.authBeta();
  
      //const identity = new PublicKey(json.pubkey).toAddress().toString()
  
      const json = JSON.parse(atob(token.split('.')[0]));
      localStorage.setItem('auth.type', 'relayx');
      localStorage.setItem('relayx.token', token);
      localStorage.setItem('relayx.auth', JSON.stringify(json));
      localStorage.setItem('relayx.paymail', json.paymail);
      localStorage.setItem('relayx.pubkey', json.pubkey);
      localStorage.setItem('relayx.origin', json.origin);
      localStorage.setItem('relayx.issued_at', json.issued_at);
      //localStorage.setItem('relayx.identity', identity);
  
      const user = {
        id: json.pubkey,
        email: json.paymail,
        name: json.paymail
      };
      dispatch({
        type: LOGIN,
        payload: {
          wallet: 'relayx',
          isLoggedIn: true,
          user
        }
      });
  
      return json;
    };
  
    const logout = () => {
      setSession(null);
      window.localStorage.removeItem('auth.type');
  
      //TODO Handcash
  
      window.localStorage.removeItem('relayx.auth');
      window.localStorage.removeItem('relayx.origin');
      window.localStorage.removeItem('relayx.token');
      window.localStorage.removeItem('relayx.pubkey');
      window.localStorage.removeItem('relayx.paymail');
      window.localStorage.removeItem('relayx.domain');
      window.localStorage.removeItem('relayx.issued_at');
      //window.localStorage.removeItem('berry-cart');
      //window.localStorage.removeItem('berry-next-js-config');
  
      //enqueueSnackbar('au revoir!');
  
      dispatch({ type: LOGOUT });
    }
  
    return (
      //@ts-ignore
      <WalletContext.Provider value={{ ...state, relayxSignIn, logout }}>{children}</WalletContext.Provider>
      )
    
}


WalletProvider.propTypes = {
  children: PropTypes.node
};

export default WalletContext;
