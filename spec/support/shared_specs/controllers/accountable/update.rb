require 'spec_helper'

RSpec.shared_examples 'controllers/accountable/update' do |model, resource, entity, role, factories|

  name = resource[0..-2].split('/').join('_')
  url = "/api/v1/#{resource}/my_account"

  describe "PUT #{url}" do
    let!(:existing_account) { FactoryGirl.create name }
    let!(:old_attributes) { current_user.attributes.to_s }
    let!(:count) { model.count }

    let(:expected_record) { serialized_record(entity, current_user.reload) }
    let(:new_attributes) { current_user.reload.attributes.to_s }
    let(:action!) { put url, params }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'valid' do

      after { expect(json_response['account']).to eq(expected_record) }
      after { expect(new_attributes).to_not eq(old_attributes) }
      after { expect(json_response['role']).to eq(role) }
      after { expect(response.status).to eq(200) }

      context 'valid params' do
        factories[:valid].each do |factory|
          let(:params) { generate_params(factory, name) }

          it { action! }
        end
      end

      context 'current user username' do
        let(:params) {
          { name => FactoryGirl.attributes_for(name, username: current_user.username.swapcase) }
        }

        it { action! }
      end
    end

    context 'invalid params' do
      after { expect(new_attributes).to eq(old_attributes) }
      after { expect(response.status).to eq(400) }

      factories[:invalid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action! }
      end
    end

    context 'existing user username' do
      let(:params) {
        { name => FactoryGirl.attributes_for(name, username: existing_account.username.swapcase) }
      }

      after { expect(new_attributes).to eq(old_attributes) }
      after { expect(response.status).to eq(409) }

      it { action! }
    end
  end
end
