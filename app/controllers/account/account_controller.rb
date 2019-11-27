class Account::AccountController < ApplicationController
  layout 'account'
  before_action :authenticate_user!

  def current_organization
    current_user.organization
  end
end

