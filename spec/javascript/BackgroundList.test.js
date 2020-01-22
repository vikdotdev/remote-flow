import React from 'react';
import { shallow } from 'enzyme'

import Loader from 'react-loader-spinner'
import BackgroundList from 'components/BackgroundList'
import BackgroundThumbnail from 'components/BackgroundThumbnail'

describe('<BackgroundList />', () => {
  let props = {};

  beforeEach(() => {
    props = {
      loading: false,
      backgrounds: [
        {
          id: '1',
          image: 'one.jpg',
          thumb: 'th-one.jpg'
        },
        {
          id: '2',
          image: 'two.jpg',
          thumb: 'th-two.jpg'
        }
      ]
    };
  });

  it('renders spinner if loading is true', () => {
    props.loading = true;
    const wrapper = shallow(<BackgroundList {...props} />);
    expect(wrapper.find(Loader)).toHaveLength(1);
  });

  it('renders multiple <BackgroundThumbnail />', () => {
    const wrapper = shallow(<BackgroundList {...props} />);
    expect(wrapper.find(BackgroundThumbnail)).toHaveLength(props.backgrounds.length);
  });
});

