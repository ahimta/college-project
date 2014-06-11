require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged in as an admin' do |args, create_factories, update_factories|

  resource = 'admin/accounts'
  url = '/api/v1/admin/accounts'
  name = resource[0..-2].split('/').join('_')
  model = Admin::Account
  entity = API::V1::Entities::Admin::Account
  role = Account::AccountManager::AdminRole

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])

    # it_behaves_like 'controllers/accountable/update', *(args + [update_factories])

    it_behaves_like 'controllers/accountable/logout', model, resource
    it_behaves_like 'controllers/accountable/username_available', resource, role
    it_behaves_like('controllers/accountable/username_available', 'recruiter/accounts',
      Account::AccountManager::RecruiterRole)

    it_behaves_like 'controllers/accountable/create', model, resource
    it_behaves_like('controllers/accountable/my_account', model, resource,
      entity, role)
  end

  context 'not allowed' do
    let!(:account) { FactoryGirl.create name }

    after { expect(response.status).to eq(401) }

    context 'update' do
      it { put "#{url}/#{account.id}" }
    end
    context 'destroy' do
      it { delete "#{url}/#{account.id}" }
    end
  end
end
