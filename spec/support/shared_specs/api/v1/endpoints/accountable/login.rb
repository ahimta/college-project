require 'spec_helper'

shared_examples '/api/v1/accountable/login' do |model, resource, entity, role|

  url = '/api/v1/accountable/login'
  name = resource.split('/').join('_')[0..-2]

  describe "POST #{url}" do
    let!(:user) { FactoryGirl.create name }
    let!(:count)  { model.count }

    let(:expected_account) { serialized_record(entity, user) }
    let(:action!) { post url, params }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'valid' do
      let(:params) {
        {login: {username: user.username, password: user.password}, role: role }
      }

      after { expect(json_response['account']).to eq(expected_account) }
      after { expect(json_response['role']).to eq(role) }
      after { expect(session[:user_id]).to eq(user.id) }
      after { expect(session[:user_type]).to eq(role) }
      after { expect(response.status).to eq(201) }

      context 'not logged in' do
        it { action! }
      end

      context 'logged in' do
        before { action! }

        it { action! }
      end
    end
    context 'invalid' do
      after { expect(session[:user_type]).to be(nil) }
      after { expect(session[:user_id]).to be(nil) }

      context 'wrong password' do
        let(:params) {
          {login: {username: user.username, password: user.password.swapcase}, role: role }
        }

        it { action! }

        after { expect(response.status).to eq(401) }
      end

      context 'invalid params' do
        after { expect(response.status).to eq(400) }

        context 'no role param' do
          let(:params) { {login: {username: user.username, password: user.password} } }

          it { action! }
        end
      end
    end
  end
end
