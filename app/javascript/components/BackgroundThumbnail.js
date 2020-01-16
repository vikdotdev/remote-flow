import React from 'react'
import PropTypes from 'prop-types'

import '../../assets/stylesheets/account/backgrounds.scss'

const BackgroundThumbnail = props => {
  return (
    <div className='thumbnail'>
      <img src={props.thumb} />
      <button className='close' />
    </div>
  );
};

export { BackgroundThumbnail }
