require 'spec_helper'

describe API::V1::Endpoints::Recruiter::Accounts do

  resource = 'recruiter/accounts'
  url = "/api/v1/#{resource}"

  args = [Recruiter::Account, API::V1::Entities::Recruiter::Account, resource]
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
    let(:_login) { {login: {username: current_user.username, password: current_user.password}} }

    before { post "#{url}/login", _login }

    context 'deletable' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :recruiter_account }

      it_behaves_like("#{url} - logged_in - deletable", args, create_factories,
        update_factories)
    end
    context 'non-deletable' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create :recruiter_account, deletable: false }

      it_behaves_like("#{url} - logged_in - non-deletable", args, create_factories,
        update_factories)
    end
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in"
  end
end
