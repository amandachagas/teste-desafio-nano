import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'
import BootstrapTable from 'react-bootstrap-table-next'
import Layout from '../layouts/layout'
import SimpleModal from '../modals/simple_modal'
import '../../../assets/stylesheets/importations/importations.css'

export default function ImportationsPage() {
  const [selectedFile, setSelectedFile] = useState(null)
  const [modalOpen, setModalOpen] = useState(false)
  const [modalTitle] = useState("Importação do CSV")
  const [modalBody, setModalBody] = useState("")

  const onChangeHandler = event => {
    setSelectedFile(event.target.files[0])
  }

  const closeModal = () => setModalOpen(false)

  const onClickHandler = () => {
    setModalBody("Importação dos deputados com suas notas fiscais em andamento.\nEste processo pode levar alguns minutos.\nAguarde!")
    setModalOpen(true)

    const data = new FormData()
    data.append('file', selectedFile)

    if(selectedFile) {
      axios.post("api/v1/deputies/import_csv", data, {
      }).then(res => {
        setModalBody("Importação Concluída com Sucesso!\nNavegue para Tabela de Deputados a fim de visualizar os resultados.")
      }).catch(resp => {
        setModalBody(`Ocorreu o seguinte error na importação:\n${resp}\nTalvez seja necessário abrir o arquivo CSV e salvar uma nova cópia.`)
      })
    } else {
      setModalBody("É necessário selecionar um arquivo para fazer a importação.")
    }
  }

  return (
    <Layout>
      {SimpleModal({modalOpen, modalTitle, modalBody, closeModal})}
      <form method="post" action="#" id="#">
        <div className="form-group files">
          <label>Faça o Upload do seu Arquivo CSV</label>
          <input type="file" name="file" onChange={onChangeHandler}/>
        </div>
        <button type="button" className="btn btn-success btn-block" onClick={onClickHandler}>Upload</button>
      </form>
    </Layout>
  )
}
