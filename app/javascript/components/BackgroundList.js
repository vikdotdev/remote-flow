import React from 'react'
import PropTypes from 'prop-types'
import { BackgroundThumbnail } from './BackgroundThumbnail'

import '../../assets/stylesheets/account/backgrounds.scss'

export default class BackgroundList extends React.Component {
  constructor(props) {
    super(props);
    this.state = { backgrounds: [] };

    this.onClick = this.onClick.bind(this);
  }

  componentDidMount() {
    fetch('/account/backgrounds', {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(res => res.json())
    .then(bgs => this.setState({ backgrounds: bgs }));
  }

  deleteBackground(id) {
    return this.state.backgrounds.filter(bg => bg.id !== id);
  }

  onClick(e, id) {
    e.preventDefault();

    fetch(`/account/backgrounds/${id}`, { method: 'DELETE' })
    .then((res) => this.setState({ backgrounds: this.deleteBackground(id) }))
    .catch(err => console.error(err))
  }

  render() {
    return (
      <>
      {
        this.state.backgrounds.map(bg => {
          return <BackgroundThumbnail
            key={bg.image.thumb.url}
            onClick={e => this.onClick(e, bg.id)}
            id={bg.id}
            img={bg.image.url}
            thumb={bg.image.thumb.url}
          />
        })
      }
      </>
    );
  }
}

BackgroundList.propTypes = {
  greeting: PropTypes.string
};
