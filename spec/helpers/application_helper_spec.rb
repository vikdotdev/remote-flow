require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'breadcrumbs helper' do
    it 'returns correct html when called with correct params' do
      breadcrumbs [
        { home: true, url: account_path },
        { title: 'Users', url: account_users_path },
        { title: 'User' }
      ]

      expect(content_for(:breadcrumbs)).to \
        include('<a href="/account"><i class="bx bx-home"></i></a>')
    end

    it 'returns nil on empty params' do
      breadcrumbs

      expect(content_for(:breadcrumbs)).to be_nil
    end
  end

  describe 'sidebar_button helper' do
    it 'returns correct html whan called with correct params' do
      html = sidebar_button(text: 'Users', path: account_users_path, icon: 'users')
      expect(html).to include('<a href="/account/users">')
      expect(html).to include('<i class="menu-livicon" data-icon="users"></i>')
    end

    it 'returns nil on empty params' do
      expect(sidebar_button).to be_nil
    end
  end
end
