require 'spec_helper'

shared_examples 'controllers/accountable/create' do |model, resource|

  url = "/api/v1/#{resource}"
  factory = resource.split('/').join('_')[0..-2]
  model = Recruiter::Account

  describe "POST #{url}" do
    context 'existing username' do
      let!(:existing_account) { FactoryGirl.create factory }
      let!(:count) { model.count }

      let(:params) {
        {factory => FactoryGirl.attributes_for(factory,
          username: existing_account.username.swapcase) }
      }

      before { expect(model.count).to eq(count) }

      it { post url, params }


      after { expect(response.status).to eq(409) }
      after { expect(model.count).to eq(count) }
    end
  end
end
