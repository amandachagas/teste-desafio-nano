import React, { Fragment } from 'react'
import Popup from 'reactjs-popup'
import 'reactjs-popup/dist/index.css'

export default function SimpleModal({ modalOpen, modalTitle, modalBody, closeModal }) {
  let pKey = 1

  const Modal = () => (
    <Popup
      open={modalOpen}
      onClose={closeModal}
      modal
    >
      <div className="modal-content">
        <div className="modal-header">
          <button
            type="button"
            className="close"
            onClick={closeModal}
            data-dismiss="modal"
          >
            &times;
          </button>
          <h4 className="modal-title">{modalTitle}</h4>
        </div>
        <div className="modal-body">
          {modalBody.split('\n').map(str => {
            pKey = pKey + 1
            return <p key={pKey}>{str}</p>
          })}
        </div>
      </div>
    </Popup>
  )

  return (
    <Fragment>
      {Modal()}
    </Fragment>
  )
}
