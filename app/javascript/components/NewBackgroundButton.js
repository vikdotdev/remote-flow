import React from 'react'
import PropTypes from 'prop-types'

const NewBackgroundButton = ({ toggleModal }) => {
  return (
    <div className='col-12 d-flex justify-content-end align-items-center px-1 mb-2'>
      <button onClick={toggleModal} className='btn btn-sm btn-light-primary'>
        Add New Background
      </button>
    </div>
  );
}

export { NewBackgroundButton };
