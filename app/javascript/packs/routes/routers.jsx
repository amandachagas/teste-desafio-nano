import React, { Fragment } from 'react'
import ImportationsPage from '../../components/importations/importations_page'
import DeputiesPage from '../../components/deputies/deputies_page'

export default function Routers({ match }) {
  const toRender = {
    'home': () => <ImportationsPage />,
    'deputies': () => <DeputiesPage />,
    'not_found': () => <h1>Página não encontrada!</h1>
  }

  const render = () => {
    if (match.isExact && match.url === '/') {
      return toRender.home()
    }

    let routePath = match.params.resource
    if(!Object.keys(toRender).includes(routePath)) return toRender['not_found']()
    if (match.params.id) routePath = `${routePath}/:id`

    return toRender[routePath]()
  }

  return (
    <Fragment>
      {render()}
    </Fragment>
  )
}
