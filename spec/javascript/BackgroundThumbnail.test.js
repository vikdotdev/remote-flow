import React from 'react';
import sinon from 'sinon';
import { shallow, mount } from 'enzyme'

import BackgroundThumbnail from 'components/BackgroundThumbnail'

describe('<BackgroundThumbnail />', () => {
  let props = {};

  beforeEach(() => {
    props = {
      image: {
        image: 'image.jpg',
        thumb: 'thumbnail.jpg'
      },
    };
  });

  it('renders link to an image', () => {
    const wrapper = mount(<BackgroundThumbnail {...props} />);
    expect(wrapper.find(`a[href="${props.image.image}"]`)).toHaveLength(1)
  });

  it('renders image thumbnail', () => {
    const wrapper = mount(<BackgroundThumbnail {...props} />);
    expect(wrapper.find(`img[src="${props.image.thumb}"]`)).toHaveLength(1)
  });

  it('has .close', () => {
    const wrapper = shallow(<BackgroundThumbnail {...props} />);
    expect(wrapper.exists('.close')).toBe(true);
  });

  it('triggers callback on .close click', () => {
    const callback = sinon.spy();
    const wrapper = mount(<BackgroundThumbnail onClick={callback} {...props} />);
    wrapper.find('.close').simulate('click');
    expect(callback.called).toBe(true);
  });
});

