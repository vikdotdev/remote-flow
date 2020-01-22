import React from 'react';
import sinon from 'sinon';
import { render } from 'enzyme'

import UploadButton from 'components/UploadButton'

describe('<UploadButton />', () => {
  it('has input with file attribute', () => {
    const wrapper = render(<UploadButton />);
    expect(wrapper.html()).toEqual(
      expect.stringContaining('type="file"')
    );
  });
});

