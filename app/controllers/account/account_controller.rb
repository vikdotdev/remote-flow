class Account::AccountController < ApplicationController
  layout 'account'

  before_action :authenticate_user!
end

