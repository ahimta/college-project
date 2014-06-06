require 'spec_helper'

shared_examples 'controllers/accountable/logout' do |model, resource|
  name = resource.split('/').join('_')[0..-2]

  describe "DELETE /api/v1/#{resource}/logout" do
    let!(:user) { FactoryGirl.create name }
    let!(:count) { model.count }

    let(:action!) { delete "/api/v1/#{resource}/logout" }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'logged in' do
      it { action! }

      after { expect(session[:user_type]).to be(nil) }
      after { expect(session[:user_id]).to be(nil) }
      after { expect(response.status).to eq(200) }
    end
  end
end
