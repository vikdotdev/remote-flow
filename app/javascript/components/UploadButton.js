import React from 'react'
import PropTypes from 'prop-types'

const UploadButton = ({ onChange }) => {
  return (
    <div className='row'>
      <div className="file-upload-div col-12 d-flex justify-content-end align-items-center px-1 mb-2">
        <div className="file-upload btn btn-sm btn-light-primary m-0">
          <span>Upload Photo</span>
          <input type="file" className='upload' onChange={onChange} />
        </div>
      </div>
    </div>
  );
}

export default UploadButton;
