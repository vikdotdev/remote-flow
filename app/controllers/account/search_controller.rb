class Account::SearchController < Account::AccountController
  def search
    @channels = Channel.search(params[:q])
    @users = User.search(params[:q])
    @pages = Page.search(params[:q])
    @galleries = Gallery.search(params[:q])
    @videos = Video.search(params[:q])
    @presentations = Presentation.search(params[:q])
  end
end
