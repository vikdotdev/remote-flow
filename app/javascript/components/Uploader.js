import React from 'react'
import PropTypes from 'prop-types'

const Uploader = ({ onChange }) => {
  return <input type="file" className='p-2' onChange={onChange} />
}

export { Uploader };
