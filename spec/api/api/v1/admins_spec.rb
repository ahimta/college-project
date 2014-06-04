require 'spec_helper'

describe API::V1::Admins do

  args = [Admin, API::V1::Entities::Admin, 'admins']
  create_factories = {
    valid: [
      :admin_with_correct_password_confirmation,
      :admin
    ],
    invalid: [
      :admin_with_incorrect_password_confirmation,
      :admin_without_full_name,
      :admin_without_username,
      :admin_without_password
    ]
  }

  update_factories = {
    invalid: (create_factories[:invalid] - [:admin_without_password]),
    valid: (create_factories[:valid] + [:admin_without_password])
  }

  describe 'POST /api/v1/admins/login' do
    let(:action!) { post '/api/v1/admins/login', params }
    let!(:admin) { FactoryGirl.create :admin }
    let(:count)  { 1 }

    before { expect(Admin.count).to eq(count) }
    after { expect(Admin.count).to eq(count) }

    context 'valid' do
      let(:params) {
        {user: {username: admin.username, password: admin.password} }
      }

      it { action! }

      after { expect(session[:user_type]).to eq('admin') }
      after { expect(session[:user_id]).to eq(admin.id) }
      after { expect(response.status).to eq(201) }
    end
    context 'invalid' do
      after { expect(session[:user_type]).to be(nil) }
      after { expect(session[:user_id]).to be(nil) }

      context 'wrong password' do
        let(:params) {
          {user: {username: admin.username, password: admin.password.swapcase} }
        }

        it { action! }

        after { expect(response.status).to eq(401) }
      end

      context 'invalid params' do
        after { expect(response.status).to eq(400) }

        context 'no user param' do
          let(:params) { {} }

          it { action! }
        end
      end
    end
  end

  context 'logged in' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])
  end

  context 'not logged in' do

  end
end
