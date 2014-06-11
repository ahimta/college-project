require 'spec_helper'

describe API::V1::Endpoints::Recruiter::Accounts do

  resource = 'recruiter/accounts'
  url = "/api/v1/#{resource}"
  role = Account::AccountManager::RecruiterRole
  model = Recruiter::Account
  entity = API::V1::Entities::Recruiter::Account

  args = [model, entity, resource]
  create_factories = {
    valid: [
      :recruiter_account_with_correct_password_confirmation,
      :recruiter_account
    ],
    invalid: [
      :recruiter_account_with_incorrect_password_confirmation,
      :recruiter_account_without_full_name,
      :recruiter_account_without_username,
      :recruiter_account_without_password
    ]
  }

  diff_factories = [:recruiter_account_without_password]

  update_factories = {
    invalid: (create_factories[:invalid] - diff_factories),
    valid: (create_factories[:valid] + diff_factories)
  }

  context 'logged in' do
    # WARNING: current_user name is not arbitrary, please don't change :-)
    let!(:current_user) { FactoryGirl.create :recruiter_account }

    let(:_login) {
      {login: {username: current_user.username, password: current_user.password}, role: role}
    }

    before { post "/api/v1/accountable/login", _login }

    it_behaves_like("#{url} - logged_in", args, create_factories,
      update_factories)
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in"
  end
end
