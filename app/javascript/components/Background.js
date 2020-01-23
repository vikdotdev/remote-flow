import React from 'react'
import PropTypes from 'prop-types'
import Loader from 'react-loader-spinner'

import BackgroundList from './BackgroundList'
import UploadButton from './UploadButton'

import "react-loader-spinner/dist/loader/css/react-spinner-loader.css"
import '../../assets/stylesheets/account/backgrounds.scss'

export default class Background extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      backgrounds: [],
      imageSpinner: true
    };

    this.fetchImages = this.fetchImages.bind(this);
    this.onDeleteClick = this.onDeleteClick.bind(this);
    this.uploadFile = this.uploadFile.bind(this);
  }

  componentDidMount() {
    this.fetchImages();
  }

  fetchImages() {
    fetch('/account/backgrounds.json')
    .then(res => res.json())
    .then(bgs => this.setState({
        backgrounds: bgs.data.map((d, attr) => ({ ...attr, id })),
        imageSpinner: false
      })
    )
    .catch(() => toastr.error('Failed to fetch images.'));
  }

  onDeleteClick(e, id) {
    e.preventDefault();

    fetch(`/account/backgrounds/${id}`, {
      headers: { 'X-CSRF-Token': this.props.csrf_token },
      method: 'DELETE'
    })
    .then(res => {
      this.setState({
        backgrounds: this.state.backgrounds.filter(bg => bg.id !== id)
      });

      toastr.success('Image successfully deleted.')
    })
    .catch(() => toastr.error('Failed to delete background.'));
  }

  uploadFile(e) {
    const form = new FormData();
    form.append('image', e.target.files[0]);

    fetch('/account/backgrounds', {
      headers: { 'X-CSRF-Token': this.props.csrf_token },
      method: 'POST',
      body: form
    })
    .then(res => {
      this.fetchImages();
      toastr.success('Image successfully uploaded.')
    })
    .catch(() => toastr.error('Failed to upload an image.'));
  }

  render() {
    return (
      <>
        <UploadButton onChange={this.uploadFile} />
        <div className='card'>
          <div className="card-body">
            <BackgroundList
              backgrounds={this.state.backgrounds}
              loading={this.state.imageSpinner}
              onDeleteClick={this.onDeleteClick}
            />
          </div>
        </div>
      </>
    );
  }
}

