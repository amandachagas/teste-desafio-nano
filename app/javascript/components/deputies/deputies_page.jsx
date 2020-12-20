import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'
import BootstrapTable from 'react-bootstrap-table-next'
import DeputiesTable from './deputies_table'
import Layout from '../layouts/layout'

export default function DeputiesPage() {
  const [deputies, setDeputies] = useState([])
  const [deputiesGridMessage, setDeputiesGridMessage] = useState("Carregando!")

  useEffect(() => {
    axios.get('/api/v1/deputies')
    .then(resp => {
      setDeputies(resp.data)
      if(resp.data.length == 0) {
        setDeputiesGridMessage("Não Deputados Cadastrados")
      }
    })
    .catch(resp => console.log(resp))
  }, [])

  return (
    <Layout>
      <DeputiesTable
        deputies={deputies}
        deputiesGridMessage={deputiesGridMessage}
      />
    </Layout>
  )
}
