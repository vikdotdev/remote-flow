import React from 'react'
import PropTypes from 'prop-types'
import { BackgroundThumbnail } from './BackgroundThumbnail'
import { NewBackgroundButton } from './NewBackgroundButton'
import { NewBackgroundModal } from './NewBackgroundModal'
import { Uploader } from './Uploader'

import '../../assets/stylesheets/account/backgrounds.scss'

export default class BackgroundList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      backgrounds: [],
      file: null,
      showModal: false
    };

    this.fetchImages = this.fetchImages.bind(this);
    this.onDeleteClick = this.onDeleteClick.bind(this);
    this.toggleModal = this.toggleModal.bind(this);
    this.fileChangeHandler = this.fileChangeHandler.bind(this);
    this.uploadFile = this.uploadFile.bind(this);
  }

  componentDidMount() {
    this.fetchImages();
  }

  fetchImages() {
    fetch('/account/backgrounds', {
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
    .then(res => res.json())
    .then(bgs => this.setState({ backgrounds: bgs }));
  }

  onDeleteClick(e, id) {
    e.preventDefault();

    fetch(`/account/backgrounds/${id}`, { method: 'DELETE' })
    .then(res => {
      this.setState({
        backgrounds: this.state.backgrounds.filter(bg => bg.id !== id)
      });
    })
    .catch(err => console.error(err))
  }

  toggleModal() {
    this.setState({ showModal: !this.state.showModal });
    console.log(this.state.showModal);
  };

  fileChangeHandler(e) {
    this.setState({ file: e.target.files[0] });
  }

  uploadFile(e) {
    const form = new FormData();
    form.append('image', this.state.file);

    fetch('/account/backgrounds', {
      method: 'POST',
      body: form
    })
    .then(res => {
      this.fetchImages();
      console.log(this.state.file)
      this.setState({ file: null })
      console.log(this.state.file)
    });
  }

  render() {
    return (
      <>
        <NewBackgroundButton toggleModal={this.toggleModal} />

        <NewBackgroundModal
          show={this.state.showModal}
          toggleModal={this.toggleModal}
          uploadFile={this.uploadFile}
        >
          <Uploader onChange={this.fileChangeHandler} />
        </NewBackgroundModal>

        <div className='d-flex flex-wrap '>
          {
            this.state.backgrounds.map(bg => {
              return <BackgroundThumbnail
                key={bg.image.thumb.url}
                onClick={e => this.onDeleteClick(e, bg.id)}
                id={bg.id}
                img={bg.image.url}
                thumb={bg.image.thumb.url}
              />
            })
          }
        </div>
      </>
    );
  }
}

