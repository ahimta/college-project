require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged_in - non-deletable' do |args, create_factories, update_factories|

  resource = 'admin/accounts'
  url = '/api/v1/admin/accounts'
  model = Admin::Account
  entity = API::V1::Entities::Admin::Account
  role = Loginable::AdminRole

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])

    it_behaves_like 'controllers/logout', model, resource
    it_behaves_like 'controllers/username_available', resource
    it_behaves_like('controllers/my_account', model, resource,
      entity, role)
  end

  context 'not allowed' do
    let!(:account) { FactoryGirl.create :admin_account, deletable: false }
    let!(:count) { model.count }

    before { expect(model.count).to eq(count) }

    after { expect(response.status).to eq(401) }
    after { expect(model.count).to eq(count) }

    context 'destroy' do
      it { delete "#{url}/#{account.id}" }
    end
  end
end
