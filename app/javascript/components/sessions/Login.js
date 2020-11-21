import React, { useState, useEffect } from 'react'
import axios from 'axios'

function Login() {
  const [login, setLogin, password, setPassword] = useState('')
  const [isLoading, setIsLoading] = useState(false)

  const url = '/v1/apis/auth/sessions'

  useEffect(() => {

  //   setIsLoading(true)

    axios({
      method: 'post',
      url: url,
      data: {
        email: login,
        password: password
      }
    })
    .then((response) => {
      setLogin(false)
      console.log(response.data)
    })
    .catch((error) => {
      setLogin(false)
      console.log(error)
    });
  })
    


  // // handelLoginChange = (event) =>{
  // //   debugger
  // //   setLogin(event.target.value)
  // // }

  return(
    <form>
      <div>
        Login
        <input type="email" name="login" id="login" onChange={}></input>
      </div>
      <div>
        Password
        <input type="password" name="login" id="login"></input>
      </div>
      <div>
        <button type="button" onClick={() => alert('sds')}>Login</button>
      </div>
    </form>
  )
}

export default Login