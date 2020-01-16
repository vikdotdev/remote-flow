import React from 'react'
import PropTypes from 'prop-types'
import { BackgroundThumbnail } from './BackgroundThumbnail'
import '../../assets/stylesheets/account/backgrounds.scss'

export default class BackgroundList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { backgrounds: [] };
  }

  componentDidMount() {
    fetch('/account/backgrounds', {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(res => res.json())
    .then(bgs => this.setState({ backgrounds: bgs.map(bg => bg.image) })).then(() => console.log(this.state));
  }

  render () {
    return (
      <>
      { this.state.backgrounds.map(bg => <BackgroundThumbnail thumb={bg.thumb.url} key={bg.thumb.url}/>) }
      </>
    );
  }
}

BackgroundList.propTypes = {
  greeting: PropTypes.string
};
