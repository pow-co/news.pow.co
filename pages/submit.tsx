import { useEffect, useState } from "react"

import { useFormik } from 'formik';

import { wrapRelayx } from 'stag-relayx'
import Script from "next/script";
import axios from "axios";

export default function Submit() {

    const [title, setTitle] = useState()
    const [url, setUrl] = useState()
    const [text, setText] = useState()

    var stag: any;

    const formik = useFormik({
        enableReinitialize: true,
        initialValues: {
          title: '',
          url: '',
          text: ''
        },
        onSubmit: async (values) => {

            //const head = await axios.get(values.url)

            //console.log({head})

            console.log('submit', values)
            //@ts-ignore
            const stag: any = wrapRelayx(window.relayone)

            //const auth = await stag.relayone.authBeta()

            let result = await stag.relayone.send({
                opReturn: [
                  'onchain',
                  '1HWaEAD5TXC2fWHDiua9Vue3Mf8V1ZmakN',
                  'answer',
                  JSON.stringify(values)
                ],
                currency: 'USD',
                amount: 0.0218,
                to: '1MqPZFc31jUetZ5hxVtG4tijJSugAcSZCQ'
              });
              let { amount, currency, identity, paymail, rawTx, satoshis, txid: resultTxid } = result;

              console.log('relayx.result', result)

            const [txid, txhex] = await stag.onchain.create({

              
                  app: 'alpha.news.pow.co',
              
                  type: 'news_link',
              
                  content: {
              
                    values
              
                  },
              
                  author: false
            });

            /*const [txid, txhex] = await stag.onchain.findOrCreate({

                where: {
              
                  app: 'alpha.news.pow.co',
              
                  type: 'news_link',
              
                  content: {
              
                    values
              
                  },
              
                  author: false
                },
              
                defaults: {
              
                  app: 'alpha.news.pow.co',
              
                  type: 'news_link',
              
                  content: {
              
                    values
              
                  },
              
                  author: false
              
                }
              
              })*/
              console.log({txid, txhex})

              
        }
      });

    function titleChanged(params: any) {
        console.log('title changed', params.target)
    }


    useEffect(() => {
        //@ts-ignore

    }, [])

    //@ts-ignore

    return (


        <div className="container">
                    <Script src="https://one.relayx.io/relayone.js" />
            <div className="header-container">
                <div className="header-logo">
                <img alt="header img" src="/images/y18.gif" width="18" height="18" />
                </div>
                <div className="header-menu-container">
                <div className="header-menu-links-left">
                    <b className="header-menu-logo"><a href="/">Submit</a></b>
                </div>
                <div className="header-menu-login-container">
                    <span className="pagetop">
                    <a href="#">Logout</a>
                    </span>
                </div>
                </div>
            </div>

            <div className="feed-container post-form">

                <form action="/r" method="post" onSubmit={formik.handleSubmit}>
                    <input type="hidden" name="fnid" value="kLnBxaQHpO9xHW9DVcqbqt" />
                    <input type="hidden" name="fnop" value="submit-page" />
                    <table border={0}>
                        <tr>
                            <td>title</td>
                            <td><input type="text" name="title" value={formik.values.title} onChange={formik.handleChange} size={50} />
                                <span style={{marginLeft:'10px'}}></span>
                            </td>
                        </tr>
                        <tr>
                            <td>url</td>
                            <td><input type="url" name="url" value={formik.values.url} onChange={formik.handleChange} size={50} /></td>
                        </tr>
                        <tr>
                            <td>text</td><td>
                            <textarea name="text" rows={4} cols={49} value={formik.values.text} onChange={formik.handleChange} wrap="virtual"></textarea></td>
                        </tr>
                        <tr>
                            <td></td><td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="submit" /></td>
                        </tr>
                        <tr style={{height: "20px"}}></tr>
                        <tr><td></td><td>Leave url blank to submit a question for discussion. If there
         is no url, text will appear at the top of the thread. If
         there is a url, text is optional.<br /><br />
.</td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>

    )
}