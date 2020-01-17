require 'rails_helper'

RSpec.describe Api::V1::ContentsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:content) { create(:content, :video, organization_id: organization.id) }

  describe 'GET #index' do
    it 'return organization by token' do
      request.headers['Token'] = organization.token
      get :index
      expect(response).to have_http_status(200)
      expect(response.headers).to have_key('Per-Page')
      expect(response.headers).to have_key('Total')
    end

    it 'return error by invalid token' do
      request.headers['Token'] = organization.token + 'Ruby'
      get :index
      expect(response).to have_http_status(400)
      expect(response.headers).to_not have_key('Per-Page')
      expect(response.headers).to_not have_key('Total')
    end
  end

  context 'when token is valid' do
    before do
      request.headers['Token'] = organization.token
    end

    describe 'GET #show' do
      it 'return content' do
        get :show, params: { id: content.id }

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response['id']).to eq(content.id)
        expect(json_response['title']).to eq(content.title)
        expect(json_response['organization_id']).to eq(content.organization_id)
      end
    end

    describe 'POST #create' do
      context 'when title field is full' do
        it 'change Content.count' do
          expect do
            post :create, params: {
              content: {
                title: 'Dunder Mifflin'
              }
            }
          end.to change(Content, :count).by(1)
        end

        it 'return new content' do
          post :create, params: {
            content: {
              title: 'Dunder Mifflin'
            }
          }

          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(200)
          expect(json_response['title']).to eq('Dunder Mifflin')
          expect(json_response['organization_id']).to eq(organization.id)
        end
      end

      context 'when title field is empty' do
        it 'not change Content.count' do
          expect do
            post :create, params: {
              content: {
                title: ''
              }
            }
          end.not_to change(Channel, :count)
        end

        it 'return status code 422' do
          post :create, params: {
            content: {
              title: ''
            }
          }

          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(422)
          expect(json_response).to include('errors')
        end
      end

      context 'when organization field is empty' do
        it 'return new content' do
          post :create, params: {
            content: {
              title: 'Dunder Mifflin',
              organization:''
            }
          }

          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(200)
          expect(json_response['title']).to eq('Dunder Mifflin')
          expect(json_response['organization_id']).to eq(organization.id)
        end
      end
    end

    describe 'PATCH #update' do
      context 'when title field is full' do
        it 'return edit content' do
          patch :update, params:{
            content:{
              title: "Sabre"
            },
            id: content.id
          }

          expect(response).to have_http_status(200)
          expect(channel.reload.title).to eq('Sabre')
        end
      end

      context 'when title field is empty' do
        it 'return status code 422' do
          patch :update, params:{
            content:{
              title: ""
            },
            id: content.id
          }

          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(422)
          expect(json_response).to include('errors')
        end
      end

      context 'when organization field is empty' do
        it 'return edit content' do
          patch :update, params:{
            content:{
              title: "Sabre",
              organization: ''
            },
            id: content.id
          }

          expect(response).to have_http_status(200)
          expect(channel.reload.organization_id).to eq(organization.id)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'return status code 200' do
        expect{ delete :destroy, params:{ id: content.id } }.to change(Content, :count).by(-1)
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'when token is invalid' do
    before do
      request.headers['Token'] = organization.token + 'Ruby'
    end

    describe 'GET #show' do
      it 'return status code 400' do
        get :show, params: { id: content.id }

        expect(response).to have_http_status(400)
      end
    end

    describe 'POST #create' do
      it 'return status code 400' do
        post :create, params: {
          content: {
            title: 'Dunder Mifflin'
          }
        }

        expect(response).to have_http_status(400)
      end
    end

    describe 'PATCH #update' do
      it 'return status code 400' do
        patch :update, params:{
          content:{
            title: "Sabre"
          },
          id: content.id
        }

        expect(response).to have_http_status(400)
      end
    end

    describe 'DELETE #destroy' do
      it 'not change Content.count' do
        expect do
          delete :destroy, params:{ id: content.id }
        end.not_to change(Content, :count)
      end

      it 'return status code 400' do
        delete :destroy, params:{ id: content.id }

        expect(response).to have_http_status(400)
      end
    end
  end
end
