require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged_in - deletable' do |args, create_factories, update_factories|

  resource = 'admin/accounts'
  url = '/api/v1/admin/accounts'

  context 'allowed' do
  end

  context 'not allowed' do
    let!(:account) { FactoryGirl.create :admin_account }
    let!(:count) { Admin::Account.count }

    before { expect(Admin::Account.count).to eq(count) }

    after { expect(Admin::Account.count).to eq(count) }
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
