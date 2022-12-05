
import useSWR from 'swr';

const baseURL = 'https://onchain.sv/api/v1'
//const baseURL = 'http://localhost:5200'

export const BASE = `${baseURL}/api/v1`;

import axios from 'axios';


//const axiosInstance = axios.create({ baseURL: process.env.HOST_API_KEY || '' });
const axiosInstance = axios.create({ baseURL });

axiosInstance.interceptors.response.use(
  (response) => response,
  (error) => Promise.reject((error.response && error.response.data) || 'Something went wrong')
);

export default axiosInstance;

export function fetcher(params: any) {
  return axios(params).then(({ data }) => {
    return data;
  });
}

export function useOnchain(path: string, queryParams: any) {
  let params = queryParams || '';
  let { data, error, mutate: refresh, isValidating: loading } = useSWR(`${BASE}${path}${params}`, fetcher);

  return { data, error, refresh, loading };
}
