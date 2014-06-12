require 'spec_helper'

shared_examples '/api/v1/recruiter/accounts - logged_in as a recruiter' do |args, create_factories, update_factories|

  resource = 'recruiter/accounts'
  url = '/api/v1/recruiter/accounts'
  model = Recruiter::Account
  entity = API::V1::Entities::Recruiter::Account
  role = Account::AccountManager::RecruiterRole

  context 'allowed' do
    it_behaves_like 'controllers/accountable/logout', model, resource
    it_behaves_like('controllers/accountable/my_account', model, resource,
      entity, role)
  end

  context 'not allowed' do
    let!(:count) { Recruiter::Account.count }

    before { expect(Recruiter::Account.count).to eq(count) }

    after { expect(Recruiter::Account.count).to eq(count) }
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

    context 'username_available' do
      it { head "#{url}/username_available?username=hi" }
    end
  end
end
