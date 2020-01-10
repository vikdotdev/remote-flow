require 'rails_helper'

RSpec.describe Api::V1::ChannelsController, type: :controller do
  let!(:organization) { create(:organization) }
  let!(:channel) { create(:channel, organization: organization) }

  context 'when token is valid' do
    before do
      request.headers['Token'] = organization.token
    end

    describe 'GET #show' do
      it 'return channel' do
        get :show, params: { id: channel.id }

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response['id']).to eq(channel.id)
      end
    end

    describe 'POST #create' do
      it 'change Channel.count' do
        expect do
          post :create, params: {
            channel: {
              name: 'Dunder Mifflin'
            }
          }
        end.to change(Channel, :count).by(1)
      end

      it 'return new channel' do
        post :create, params: {
          channel: {
            name: 'Dunder Mifflin'
          }
        }

        json_response = JSON.parse(response.body)

        expect(response).to have_http_status(200)
        expect(json_response['name']).to eq('Dunder Mifflin')
      end

      context 'when organization field is empty' do
        it 'return new channel' do
          post :create, params: {
            channel: {
              name: 'Dunder Mifflin',
              organization:''
            }
          }

          json_response = JSON.parse(response.body)

          expect(response).to have_http_status(200)
          expect(json_response['organization_id']).to eq(organization.id)
        end
      end
    end

    describe 'PATCH #update' do
      it 'return edit channel' do
        patch :update, params:{
          channel:{
            name: "Sabre"
          },
          id: channel.id
        }

        expect(response).to have_http_status(200)
        expect(channel.reload.name).to eq('Sabre')
      end

      context 'when organization field is empty' do
        it 'return edit channel' do
          patch :update, params:{
            channel:{
              name: "Sabre",
              organization: ''
            },
            id: channel.id
          }

          expect(response).to have_http_status(200)
          expect(channel.reload.organization_id).to eq(organization.id)
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'return status code 200' do
        expect{ delete :destroy, params:{ id: channel.id } }.to change(Channel, :count).by(-1)
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
        get :show, params: { id: channel.id }

        expect(response).to have_http_status(400)
      end
    end

    describe 'POST #create' do
      it 'return status code 400' do
        post :create, params: {
          channel: {
            name: 'Dunder Mifflin'
          }
        }

        expect(response).to have_http_status(400)
      end
    end

    describe 'PATCH #update' do
      it 'return status code 400' do
        patch :update, params:{
          channel:{
            name: "Sabre"
          },
          id: channel.id
        }

        expect(response).to have_http_status(400)
      end
    end

    describe 'DELETE #destroy' do
      it 'return status code 400' do
        expect do
          delete :destroy, params:{ id: channel.id }
        end.not_to change(Channel, :count)

        expect(response).to have_http_status(400)
      end
    end
  end
end
