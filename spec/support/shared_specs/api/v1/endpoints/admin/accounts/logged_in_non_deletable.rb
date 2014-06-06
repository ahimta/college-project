require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged_in - non-deletable' do |args, create_factories, update_factories|

  resource = 'admin/accounts'
  url = '/api/v1/admin/accounts'

  describe "HEAD #{url}/username_available" do
    let(:action!) { head "#{url}/username_available?username=#{username}" }
    let(:username) { 'hi' }

    context 'available' do
      it { action! }

      after { expect(response.status).to eq(200) }
    end

    context 'not available' do
      let!(:account) { FactoryGirl.create :admin_account, username: username.swapcase }

      it { action! }

      after { expect(response.status).to eq(409) }
    end
  end

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])
    it_behaves_like('controllers/my_account', Admin::Account, resource,
      API::V1::Entities::Admin::Account, Loginable::AdminRole)
  end

  context 'not allowed' do
    let!(:account) { FactoryGirl.create :admin_account, deletable: false }
    let!(:count) { Admin::Account.count }

    before { expect(Admin::Account.count).to eq(count) }

    after { expect(Admin::Account.count).to eq(count) }
    after { expect(response.status).to eq(401) }

    context 'destroy' do
      it { delete "#{url}/#{account.id}" }
    end
  end
end
