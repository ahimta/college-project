require 'spec_helper'

shared_examples 'controllers/accountable/my_account' do |model, resource, entity, role, factories|

  name = resource[0..-2]
  url = "/api/v1/accountable"

  let!(:count) { model.count }
  let(:expected_record) { serialized_record(entity, current_user) }

  after { expect(json_response['account']).to eq(expected_record) }
  after { expect(json_response['role']).to eq(role) }

  describe "GET #{url}/my_account" do
    before { expect(model.count).to eq(count) }

    it { get "#{url}/my_account" }

    after { expect(model.where(id: current_user.id).first).to eq(current_user) }
    after { expect(session[:user_id]).to be(current_user.id) }
    after { expect(session[:user_type]).to eq(role) }
    after { expect(response.status).to eq(200) }
    after { expect(model.count).to eq(count) }
  end

  describe "DELETE #{url}/my_account" do
    before { expect(model.count).to eq(count) }

    it { delete "#{url}/my_account" }

    after { expect(model.where(id: current_user.id).first).to be(nil) }
    after { expect(session[:user_type]).to be(nil) }
    after { expect(session[:user_id]).to be(nil) }
    after { expect(model.count).to eq(count - 1) }
    after { expect(response.status).to eq(200) }
  end

  skip "PUT #{url}/my_account" do
    let!(:record) { FactoryGirl.create name }
    let!(:count) { model.count }

    let(:action!) { put "#{url}/my_account", params }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'valid' do
      let(:expected_record) { serialized_record(entity, model.first) }

      factories[:valid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action! }

        # order matters record.attributes first then record.reload.attributes
        # after { expect(record.attributes.to_s).to_not eq(record.reload.attributes.to_s) }
        after { expect(json_response[name]).to eq(expected_record) }
        after { expect(response.status).to eq(200) }
      end
    end

    context 'invalid' do
      factories[:invalid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action! }

        after { expect(model.first.attributes.to_s).to eq(record.attributes.to_s) }
        after { expect(response.status).to eq(400) }
      end
    end
  end
end
