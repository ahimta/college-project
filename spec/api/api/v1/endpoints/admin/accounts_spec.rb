require 'spec_helper'

describe API::V1::Endpoints::Admin::Accounts do

  resource = 'admin/accounts'
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
    let!(:_admin) { FactoryGirl.create :admin_account }
    let(:_login) { {login: {username: _admin.username, password: _admin.password}} }

    before { post "#{url}/login", _login }

    it_behaves_like "#{url} - logged_in", args, create_factories, update_factories
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in"
  end
end
