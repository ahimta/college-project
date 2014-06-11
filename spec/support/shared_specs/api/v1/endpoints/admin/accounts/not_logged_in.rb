require 'spec_helper'

shared_examples '/api/v1/admin/accounts - not_logged_in' do

  resource = 'admin/accounts'
  url = "/api/v1/#{resource}"

  role = Account::AccountManager::AdminRole

  context 'allowed' do
    it_behaves_like('controllers/accountable/login', Admin::Account, resource,
      API::V1::Entities::Admin::Account, role)
  end

  context 'forbidden' do
    after { expect(response.status).to eq(401) }

    context 'index' do
      it { get url }
    end
    context 'show' do
      it { get "#{url}/99" }
    end
    context 'create' do
      it { post url }
    end
    context 'update' do
      it { put "#{url}/99" }
    end
    context 'destroy' do
      it { delete "#{url}/99" }
    end

    context 'logout' do
      it { delete '/api/v1/accountable/logout' }
    end
    pending 'username_available' do
      it { head "/api/v1/accountable/username_available?username=hi&role=#{role}" }
    end
    context 'my_account' do
      it { get "/api/v1/accountable/my_account" }
      it { delete "/api/v1/accountable/my_account" }
    end
  end
end
