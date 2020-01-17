import React from 'react'
import PropTypes from 'prop-types'

import Loader from 'react-loader-spinner'
import { BackgroundThumbnail } from './BackgroundThumbnail'

class BackgroundList extends React.Component {
  constructor(props) {
    super(props);
    this.renderImages = this.renderImages.bind(this);
  }

  renderImages() {
    if (this.props.loading) {
      return (
        <Loader
          type="TailSpin"
          color="#aaaaaa"
          height={100}
          width={100}
        />
      );
    } else {
      return this.props.backgrounds.map(bg => {
        return (
          <BackgroundThumbnail
            key={bg.id}
            onClick={e => this.props.onDeleteClick(e, bg.id)}
            image={{image: bg.image.url, thumb: bg.image.thumb.url}}
          />
        );
      });
    }
  }

  render() {
    return (
      <div className='d-flex flex-wrap vh-100'>
        { this.renderImages() }
      </div>
    );
  }
}

export { BackgroundList };
