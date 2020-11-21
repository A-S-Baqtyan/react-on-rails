import React, { useState, useEffect } from 'react'
import axios from 'axios'

function List() {
  const [users, setUsers] = useState([])
  const [isLoading, setIsLoding] = useState(true)

  const url = 'https://jsonplaceholder.typicode.com/posts'

  useEffect(() => {
    axios.get(url)
      .then(response => {
        setUsers(response.data)
        setIsLoding(false)
        console.log(response)
      })
      .catch(error => {
        console.log(error)
        setIsLoding(false)
      })
  }, [])

  return(

  )
}

export default List