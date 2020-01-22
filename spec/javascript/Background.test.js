import React from 'react';
import sinon from 'sinon';
import { shallow, mount } from 'enzyme'

import Background from 'components/Background'
import UploadButton from 'components/UploadButton'
import BackgroundList from 'components/BackgroundList'

describe('<Background />', () => {
  it('renders one <UploadButton />', () => {
    const wrapper = shallow(<Background />);
    expect(wrapper.find(UploadButton)).toHaveLength(1);
  });

  it('renders one <BackgroundList />', () => {
    const wrapper = shallow(<Background />);
    expect(wrapper.find(BackgroundList)).toHaveLength(1);
  });

  it('renders one <BackgroundList />', () => {
    const wrapper = shallow(<Background />);
    expect(wrapper.find(BackgroundList)).toHaveLength(1);
  });

  it('calls fetchImages on mount', () => {
    sinon.spy(Background.prototype, 'fetchImages');
    const wrapper = mount(<Background />);
    expect(Background.prototype.fetchImages).toHaveProperty('callCount', 1);
  });
});

