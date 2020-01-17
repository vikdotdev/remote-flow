import React from 'react'
import PropTypes from 'prop-types'

const NewBackgroundModal = ({ show, toggleModal, uploadFile, children }) => {
  const showHideClassName = show ? 'modal d-block' : 'modal d-none';

  return (
    <div className={showHideClassName}>
      <section className='modal-main '>
        {children}
        <div className='d-flex justify-content-end'>
          <button className='btn btn-light-secondary mr-50' onClick={toggleModal}>Cancel</button>
          <button className='btn btn-light-primary' onClick={e => (toggleModal(), uploadFile(e))}>Add</button>
        </div>
      </section>
    </div>
  );
}

export { NewBackgroundModal };
