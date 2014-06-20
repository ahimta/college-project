require 'spec_helper'

shared_examples '/api/v1/recruiter/accounts - logged in as a recruiter' do |args, create_factories, update_factories|

  resource = 'recruiter/accounts'
  url = '/api/v1/recruiter/accounts'
  model = Recruiter::Account
  entity = API::V1::Entities::Recruiter::Account
  role = Account::AccountManager::RecruiterRole

  context 'allowed' do
    it_behaves_like('controllers/accountable/update', model, resource, entity, role,
      update_factories)
  end

  context 'not allowed' do
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
  end

  context 'current user user deleted while logged in' do
    it_behaves_like 'accountable - logged in - deleted', resource
  end
end
