import React from 'react'
import PropTypes from 'prop-types'

import Loader from 'react-loader-spinner'
import BackgroundThumbnail from './BackgroundThumbnail'

export default class BackgroundList extends React.Component {
  constructor(props) {
    super(props);
    this.renderImage = this.renderImage.bind(this);
  }

  renderImage(bg) {
    return (
      <BackgroundThumbnail
        key={bg.id}
        onClick={e => this.props.onDeleteClick(e, bg.id)}
        image={bg}
      />
    );
  }

  renderLoader() {
    return (
      <div className='d-flex flex-wrap justify-content-center align-items-center vw-100 background-spinner-container'>
        <Loader
          type='TailSpin'
          color='#aaaaaa'
          height={100}
          width={100}
        />
      </div>
    );
  }

  render() {
    const { loading } = this.props;
    const list = this.props.backgrounds.map(this.renderImage);

    return(
      <div className='background-spinner-container d-flex flex-wrap'>
        { list }
        { loading && this.renderLoader() }
      </div>
    );
  }
}

