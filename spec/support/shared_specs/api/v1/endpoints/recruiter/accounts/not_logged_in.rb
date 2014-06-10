require 'spec_helper'

shared_examples '/api/v1/recruiter/accounts - not_logged_in' do
  resource = 'recruiter/accounts'
  url = "/api/v1/#{resource}"

  context 'allowed' do
    it_behaves_like('controllers/accountable/login', Recruiter::Account, resource,
      API::V1::Entities::Recruiter::Account, Account::AccountManager::RecruiterRole)
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
      it { delete "#{url}/logout" }
    end
    context 'username_available' do
      it { head "#{url}/username_available?username=hi" }
    end
    context 'my_account' do
      it { get "#{url}/my_account" }
      it { delete "#{url}/my_account" }
    end
  end
end
