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
    let(:_login) { {login: {username: current_user.username, password: current_user.password}} }

    before { post "#{url}/login", _login }

    context 'deletable' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :admin_account }

      it_behaves_like("#{url} - logged_in - deletable", args, create_factories,
        update_factories)
    end
    context 'non-deletable' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :admin_account, deletable: false }

      it_behaves_like("#{url} - logged_in - non-deletable", args, create_factories,
        update_factories)
    end
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in"
  end
end
