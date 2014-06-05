require 'spec_helper'

describe API::V1::Endpoints::Admins do

  args = [Admin::Account, API::V1::Entities::Admin, 'admins', :admin_account]
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

    before { post '/api/v1/admins/login', login }

    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])
  end

  context 'not logged in' do
    context 'allowed' do
      it_behaves_like 'controllers/login', Admin::Account, 'admins', :admin_account, Loginable::AdminRole
      it_behaves_like 'controllers/logout', Admin::Account, 'admins', :admin_account
    end

    context 'forbidden' do
      after { expect(response.status).to eq(401) }

      context 'create' do
        it { post '/api/v1/admins' }
      end
      context 'index' do
        it { get '/api/v1/admins' }
      end
      context 'show' do
        it { get '/api/v1/admins/99' }

      end
      context 'update' do
        it { put '/api/v1/admins/99' }
      end
      context 'destroy' do
        it { delete '/api/v1/admins/99' }
      end
    end
  end
end
