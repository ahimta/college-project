require 'spec_helper'

shared_examples 'controllers/accountable/login' do |model, resource, user_type|
  url = "/api/v1/#{resource}/login"
  name = resource.split('/').join('_')[0..-2]

  describe "POST #{url}" do
    let(:action!) { post url, params }
    let!(:user) { FactoryGirl.create name }
    let(:count)  { 1 }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'valid' do
      let(:params) {
        {login: {username: user.username, password: user.password} }
      }

      it { action! }
      it { action! }

      after { expect(session[:user_type]).to eq(user_type) }
      after { expect(session[:user_id]).to eq(user.id) }
      after { expect(response.status).to eq(201) }
    end
    context 'invalid' do
      after { expect(session[:user_type]).to be(nil) }
      after { expect(session[:user_id]).to be(nil) }

      context 'wrong password' do
        let(:params) {
          {login: {username: user.username, password: user.password.swapcase} }
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
end
