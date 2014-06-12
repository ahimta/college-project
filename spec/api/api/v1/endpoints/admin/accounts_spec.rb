require 'spec_helper'

RSpec.describe API::V1::Endpoints::Admin::Accounts, type: :request do

  model = Admin::Account
  resource = 'admin/accounts'
  url = "/api/v1/#{resource}"
  entity = API::V1::Entities::Admin::Account

  args = [model, entity, resource]
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
    let(:_login) {
      {login: {username: current_user.username, password: current_user.password}, role: role}
    }

    before { post "/api/v1/accountable/login", _login }

    context 'as an admin' do
      let!(:current_user) { FactoryGirl.create :admin_account }

      let(:role) { Account::AccountManager::AdminRole }

      it_behaves_like "#{url} - logged in as an admin", args, create_factories, update_factories
    end

    context 'as a recruiter' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :recruiter_account }

      let(:role) { Account::AccountManager::RecruiterRole }

      it_behaves_like "#{url} - logged in as a recruiter", args, create_factories, update_factories
    end
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in"
  end
end
