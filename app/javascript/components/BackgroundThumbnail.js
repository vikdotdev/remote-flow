import React from 'react'
import PropTypes from 'prop-types'

const BackgroundThumbnail = props => {
  return (
    <a href={props.img} target='_blank'>
      <div className='thumbnail'>
        <img src={props.thumb} />
        <button onClick={props.onClick} className='close' />
      </div>
    </a>
  );
};

export { BackgroundThumbnail }
