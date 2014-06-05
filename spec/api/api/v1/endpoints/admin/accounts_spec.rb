require 'spec_helper'

describe API::V1::Endpoints::Admin::Accounts do

  resource = 'admin/accounts'
  collection = 'admin_accounts'
  url = "/api/v1/#{resource}"

  args = [Admin::Account, API::V1::Entities::Admin::Account, resource]
  create_factories = {
    valid: [
      :admin_account_with_correct_password_confirmation,
      :admin_account
    ],
    invalid: [
      :admin_account_with_incorrect_password_confirmation,
      :admin_account_without_full_name,
      :admin_account_without_username,
      :admin_account_without_password
    ]
  }

  diff_factories = [:admin_account_without_password]

  update_factories = {
    invalid: (create_factories[:invalid] - diff_factories),
    valid: (create_factories[:valid] + diff_factories)
  }

  context 'logged in' do
    let!(:admin) { FactoryGirl.create :admin_account }
    let(:login) { {login: {username: admin.username, password: admin.password}} }

    before { post "/api/v1/#{resource}/login", login }

    it_behaves_like 'controllers/index', *(args + [collection])
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])
  end

  context 'not logged in' do
    context 'allowed' do
      it_behaves_like 'controllers/login', Admin::Account, resource, Loginable::AdminRole
      it_behaves_like 'controllers/logout', Admin::Account, resource
    end

    context 'forbidden' do
      after { expect(response.status).to eq(401) }

      context 'create' do
        it { post url }
      end
      context 'index' do
        it { get url }
      end
      context 'show' do
        it { get "#{url}/99" }

      end
      context 'update' do
        it { put "#{url}/99" }
      end
      context 'destroy' do
        it { delete "#{url}/99" }
      end
    end
  end
end
