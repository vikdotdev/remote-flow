import React from 'react'
import PropTypes from 'prop-types'

const BackgroundThumbnail = ({ img, thumb, onClick }) => {
  return (
    <a href={img} target='_blank'>
      <div className='thumbnail'>
        <img src={thumb} />
        <button onClick={onClick} className='close' />
      </div>
    </a>
  );
};

export { BackgroundThumbnail };
