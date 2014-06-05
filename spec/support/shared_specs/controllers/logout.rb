require 'spec_helper'

shared_examples 'controllers/logout' do |model, resource|
  name = resource[0...-1]

  describe "DELETE /api/v1/#{resource}/logout" do
    let!(:user) { FactoryGirl.create name }
    let!(:count) { model.count }

    let(:action!) { delete "/api/v1/#{resource}/logout" }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'logged in' do
      let(:login) { {login: {username: user.username, password: user.password}} }

      before { post "/api/v1/#{resource}/login", login }

      it { action! }

      after { expect(session[:user_type]).to be(nil) }
      after { expect(session[:user_id]).to be(nil) }
      after { expect(response.status).to eq(200) }
    end

    context 'not logged in' do
      it { action! }

      after { expect(response.status).to eq(401) }
    end
  end
end
