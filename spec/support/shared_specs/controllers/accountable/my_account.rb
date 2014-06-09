require 'spec_helper'

shared_examples 'controllers/accountable/my_account' do |model, resource, entity, role|

  name = resource[0..-2]
  url = "/api/v1/#{resource}"

  after { expect(json_response['role']).to eq(Loginable::AdminRole) }
  after { expect(json_response['account']).to eq(expected_record) }

  describe "GET #{url}/my_account" do
    let(:expected_record) { serialized_record(entity, current_user) }
    let!(:count) { model.count }

    before { expect(model.count).to eq(count) }

    it { get "#{url}/my_account" }

    after { expect(model.where(id: current_user.id).first).to eq(current_user) }
    after { expect(session[:user_id]).to be(current_user.id) }
    after { expect(session[:user_type]).to eq(role) }
    after { expect(response.status).to eq(200) }
    after { expect(model.count).to eq(count) }
  end

  describe "DELETE #{url}/my_account" do
    let(:expected_record) { serialized_record(entity, current_user) }
    let!(:count) { model.count }

    before { expect(model.count).to eq(count) }

    it { delete "#{url}/my_account" }

    after { expect(model.where(id: current_user.id).first).to be(nil) }
    after { expect(session[:user_type]).to be(nil) }
    after { expect(session[:user_id]).to be(nil) }
    after { expect(model.count).to eq(count - 1) }
    after { expect(response.status).to eq(200) }
  end
end
