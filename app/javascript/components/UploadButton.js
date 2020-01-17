import React from 'react'
import PropTypes from 'prop-types'

const UploadButton = ({ onChange }) => {
  return (
    <div className="file-upload-div">
      <div className="file-upload btn btn-sm btn-light-primary">
        <span>Upload Photo</span>
        <input type="file" className='upload p-2' onChange={e => onChange(e)} />
      </div>
    </div>
  );
}

export { UploadButton };
