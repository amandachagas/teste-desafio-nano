import React, { useState, useEffect, Fragment } from 'react'
import axios from 'axios'
import BootstrapTable from 'react-bootstrap-table-next'
import InvoicesTable from '../invoices/invoices_table'
import '../../../assets/stylesheets/deputies/deputies.css'

export default function DeputiesTable({ deputies, deputiesGridMessage }) {
  const deputyImageUrl = (registered_id) => {
    if (registered_id === undefined) return ''
    return `http://www.camara.leg.br/internet/deputado/bandep/${registered_id}.jpg`
  }

  const columns = [
    {
      dataField: '',
      text: 'Foto',
      formatter: (cell, row, rowIndex, extraData) => (
        <img
          className="img-deputy-photo"
          src={deputyImageUrl(row.registered_id)}
          alt={row.full_name}
        />
      )
    },
    {
      dataField: 'full_name',
      text: 'Nome'
    },
    {
      dataField: 'cpf',
      text: 'CPF'
    },
    {
      dataField: 'political_party',
      text: 'Partido'
    },
    {
      dataField: 'sum_invoices_net_values',
      text: 'Gastos Totais'
    }
  ]

  const invoicesGridMessage = "Não há Nota Fiscal Cadastrada"

  const expandRow = () => ({
    renderer: row => (
      <InvoicesTable invoices={row.invoices} invoicesGridMessage={invoicesGridMessage} />
    ),
    showExpandColumn: true
  })

  return (
    <div className="container deputies-container">
      <BootstrapTable
        keyField='id'
        data={deputies}
        columns={columns}
        striped
        hover
        condensed
        noDataIndication={deputiesGridMessage}
        expandRow={expandRow()}
      />
    </div>
  )
}
