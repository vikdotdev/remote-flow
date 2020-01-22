import React from 'react';
import sinon from 'sinon';
import { shallow, render, mount } from 'enzyme'

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

  xit('renders link to an image', () => {
    const wrapper = render(<BackgroundThumbnail {...props} />);
    expect(wrapper.html()).toEqual(
      expect.stringContaining(`href="${props.image.image}"`)
    );
  });

  it('renders image thumbnail', () => {
    const wrapper = render(<BackgroundThumbnail {...props} />);
    expect(wrapper.html()).toEqual(
      expect.stringContaining(`src="${props.image.thumb}"`)
    );
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

