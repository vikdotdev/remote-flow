class PublicController < ApplicationController
  layout 'public'

  def index
    set_meta_tags title: 'Public page'
  end

  def pricing
    set_meta_tags title: 'Pricing'
  end

  def about_us
    set_meta_tags title: 'About us'
  end

  def contact_us
    set_meta_tags title: 'Contatc us'
  end
end
