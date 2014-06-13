require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged in as an admin' do |args, create_factories, update_factories|

  resource = 'admin/accounts'
  url = "/api/v1/#{resource}"
  model = Admin::Account

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])

    it_behaves_like 'controllers/accountable/create', model, resource
  end

  context 'not allowed' do
    after { expect(response.status).to eq(401) }

    context 'update' do
      it { put "#{url}/99" }
    end
    context 'destroy' do
      it { delete "#{url}/99" }
    end
  end
end
