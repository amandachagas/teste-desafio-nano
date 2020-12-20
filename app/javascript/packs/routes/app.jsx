import React from 'react'
import { BrowserRouter, Route, Switch } from 'react-router-dom'
import Routers from './routers'

export default function App() {
  const renderPage = (match) => {
    return <Routers match={match} /> 
  }

  return (
    <BrowserRouter>
      <Switch>
        <Route
          exact
          path="/"
          render={({ match }) => renderPage(match)}
        />
        <Route
          exact
          path='/:resource'
          render={({ match }) => renderPage(match)}
        />
        <Route
          exact
          path='/:resource/:id'
          render={({ match }) => renderPage(match)}
        />
      </Switch>
    </BrowserRouter>
  )
}
