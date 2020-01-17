import React from 'react'
import PropTypes from 'prop-types'

const BackgroundThumbnail = props => {
  const { image, thumb } = props.image;

  return (
    <a href={image} target='_blank'>
      <div className='thumbnail'>
        <img src={thumb} />
        <button onClick={props.onClick} className='close' />
      </div>
    </a>
  );
};

export { BackgroundThumbnail };
