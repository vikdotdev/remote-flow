require 'rails_helper'

RSpec.describe Account::ContentsController, type: :controller do
  render_views

  let!(:organization) { create(:organization) }
  let!(:another_organization) { create(:organization) }
  let!(:user) { create(:user, organization: organization) }
  let!(:video) { create(:video, title: 'Danialberg', organization: organization) }
  let!(:page) { create(:page, organization: organization) }
  let!(:presentation) { create(:presentation, organization: organization) }
  let(:uploaded_file) { fixture_file_upload('spec/files/example.pdf') }

  context 'when not logged in' do
    describe 'GET #index' do
      it 'redirects to login page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #show' do
      it 'redirects to login page' do
        get :show, params: { id: video.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #new' do
      it 'redirects to login page' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'redirects to login page' do
        post :create, params: { title: video.title }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'redirects to login page' do
        get :edit, params: { id: video.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to login page' do
        patch :update, params: {
          content: {
            title: 'Theofurt'
          },
          id: video.id
        }

        expect(response).to redirect_to(new_user_session_path)
        expect(video.title).not_to eq('Theofurt')
        expect(video.title).to eq('Danialberg')
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to login page' do
        expect do
          delete :destroy, params: { id: video.id }
        end.not_to change(Content, :count)

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  context 'when logged in as user' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end

    describe 'GET #show' do
      it 'renders show template' do
        get :show, params: { id: video.id }
        expect(response).to be_successful
        expect(response).to render_template(:show)
      end
    end

    describe 'GET #new' do
      it 'renders new template' do
        get :new, params: { type: video.type }
        expect(response).to render_template(:new)
      end
    end

    describe 'GET #edit' do
      it 'renders edit template' do
        get :edit, params: { id: video.id }
        expect(response).to be_successful
        expect(response).to render_template(:edit)
      end
    end

    describe 'POST #create' do
      it 'redirects to show page' do
        expect do
          post :create, params: {
            content: {
              title: video.title,
              organization_id: video.organization.id
            }
          }
        end.to change(Content, :count).by(1)

        expect(response).to redirect_to(account_content_path(assigns(:content)))
      end

      it 'renders new template if title is blank' do
        post :create, params: {
          content: {
            type: video.type,
            title: '',
            organization_id: video.organization.id
          }
        }
        expect(response).to render_template(:new)
        expect(video.title).to eq('Danialberg')
      end

      it 'creates presentation content type' do
        expect do
          post :create, params: {
            content: {
              type: 'Presentation',
              title: 'Presentation',
              file: uploaded_file
            }
          }
        end.to change(Content, :count).by(1)

        expect(Content.last.file.file.original_filename).to eq(uploaded_file.original_filename)
        expect(assigns(:content).title).to eq('Presentation')
      end
    end

    describe 'PATCH #update' do
      it 'updates content title' do
        patch :update, params: {
          content: {
            title: 'Theofurt'
          },
          id: video.id
        }

        expect(response).to redirect_to(account_content_path(assigns(:content)))
        expect(assigns(:content).title).not_to eq('Danialberg')
        expect(assigns(:content).title).to eq('Theofurt')
      end

      it 'renders edit action on blank title' do
        patch :update, params: {
          content: {
            title: ''
          },
          id: video.id
        }

        expect(video.title).to eq('Danialberg')
        expect(response).to render_template(:edit)
      end

      it 'cannot change content organization' do
        patch :update, params: {
          content: {
            organization_id: another_organization.id
          },
          id: video.id
        }

        expect(assigns(:content).organization_id).not_to eq(another_organization.id)
        expect(response).to redirect_to(account_content_path(assigns(:content)))
      end
    end


    describe 'DELETE #destroy' do
      it 'changes Content.count' do
        expect do
          delete :destroy, params: { id: video.id }
        end.to change(Content, :count).by(-1)
      end
    end
  end

  context 'when a user tries to' do
    before do
      sign_in user
    end

    describe 'GET #index' do
      it 'search by title' do
        get :index, params: { q: { title_start: "Dani" } }
        expect(assigns(:contents)).to eq [video]
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'search by type' do
        get :index, params: { q: { type_eq: 'Page' } }
        expect(assigns(:contents)).to eq [page]
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'sort by descending id' do
        get :index, params: { q: { s: 'id desc' } }
        expect(assigns(:contents).to_a).to eq Content.all.order('id DESC').to_a
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end

      it 'sort by ascending title' do
        get :index, params: { q: { s: 'title asc' } }
        expect(assigns(:contents).to_a).to eq Content.all.order('title ASC').to_a
        expect(response).to be_successful
        expect(response).to render_template(:index)
      end
    end
  end

end
