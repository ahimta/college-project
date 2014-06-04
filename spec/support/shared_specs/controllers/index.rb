require 'spec_helper'

shared_examples 'controllers/index' do |model, entity, resource|

  name = resource[0..-2]
  url = "/api/v1/#{resource}"

  describe "GET #{url}" do
    let(:action) { get url }

    context 'empty' do
      let!(:count) { model.count }

      before { expect(model.count).to eq(count) }

      it { action }

      after { expect(json_response).to eq(serialized_record(entity, model.all)) }
      after { expect(json_response[resource].length).to eq(count) }
      after { expect(response.status).to eq(200) }
      after { expect(model.count).to eq(count) }
    end

    context 'not empty' do
      let(:expected_records) { serialized_record(entity, model.order('id desc')) }
      let!(:_) { FactoryGirl.create_list name, 3 }
      let!(:_) { FactoryGirl.create name }
      let!(:count) { model.count }

      before { expect(model.count).to eq(count) }

      it { action }

      after { expect(json_response).to eq(expected_records) }
      after { expect(response.status).to eq(200) }
      after { expect(model.count).to eq(count) }
    end
  end
end
