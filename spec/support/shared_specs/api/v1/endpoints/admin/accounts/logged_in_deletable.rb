require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged_in - deletable' do |args, create_factories, update_factories|

  url = '/api/v1/admin/accounts'

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/update', *(args + [update_factories])
  end

  context 'not allowed' do
    let!(:account) { FactoryGirl.create :admin_account }
    let!(:count) { Admin::Account.count }

    before { expect(Admin::Account.count).to eq(count) }

    after { expect(Admin::Account.count).to eq(count) }
    after { expect(response.status).to eq(401) }

    context 'create' do
      it { post url }
    end
    context 'destroy' do
      it { delete "#{url}/#{account.id}" }
    end
    context 'username_available' do
      it { head "#{url}/username_available?username=hi" }
    end
  end
end
