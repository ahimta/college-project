require 'spec_helper'

RSpec.describe API::V1::Endpoints::Accountable, type: :request do

  recruiter = {
    model: Recruiter::Account, resource: 'recruiter/accounts', factory: :recruiter_account,
    entity: API::V1::Entities::Recruiter::Account, role: Account::AccountManager::RecruiterRole
  }
  admin = {
    model: Admin::Account, resource: 'admin/accounts', factory: :admin_account,
    entity: API::V1::Entities::Admin::Account, role: Account::AccountManager::AdminRole
  }

  url = '/api/v1/accountable'

  context 'not logged in' do
    context 'allowed' do
      context 'login' do
        context 'as a recruiter' do
          it_behaves_like('controllers/accountable/login', recruiter[:model], recruiter[:resource],
            recruiter[:entity], recruiter[:role])
        end

        context 'as an admin' do
          it_behaves_like('controllers/accountable/login', admin[:model], admin[:resource],
            admin[:entity], admin[:role])
        end
      end
    end

    context 'not allowed' do
      after { expect(response.status).to eq(401) }

      context 'logout' do
        it { delete "#{url}/logout" }
      end
      context 'username_available' do
        it { head "#{url}/username_available?username=hi&role=r" }
      end
      context 'my_account' do
        it { delete "#{url}/my_account" }
        it { get "#{url}/my_account" }
      end
    end
  end

  context 'logged in' do
    let(:login) {
      {
        login: {username: current_user.username, password: current_user.password},
        role: role
      }
    }

    before { post "#{url}/login", login }

    context 'as a recruiter' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create recruiter[:factory] }
      let(:role) { recruiter[:role] }

      context 'allowed' do
        it_behaves_like 'controllers/accountable/logout', recruiter[:model], recruiter[:resource]

        it_behaves_like('controllers/accountable/my_account', recruiter[:model],
          recruiter[:resource], recruiter[:entity], recruiter[:role])
      end

      context 'not allowed' do
        context 'username_available' do
          it { head "#{url}/username_available?username=hi&role=#{recruiter[:role]}" }
          it { head "#{url}/username_available?username=hi&role=#{admin[:role]}" }
        end
      end
    end

    context 'as an admin' do
      # WARNING: current_user name is not arbitrary, please don't change :-)
      let!(:current_user) { FactoryGirl.create admin[:factory] }
      let(:role) { admin[:role] }

      context 'allowed' do
        it_behaves_like 'controllers/accountable/logout', admin[:model], admin[:resource]

        it_behaves_like('controllers/accountable/username_available', recruiter[:resource],
          recruiter[:role])

        it_behaves_like 'controllers/accountable/username_available', admin[:resource], admin[:role]

        it_behaves_like('controllers/accountable/my_account', admin[:model],
          admin[:resource], admin[:entity], admin[:role])
      end

      context 'not allowed' do
      end
    end
  end
end
