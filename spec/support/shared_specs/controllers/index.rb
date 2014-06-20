require 'spec_helper'

shared_examples 'controllers/index' do |model, entity, resource|

  name = resource.split('/').join('_')[0..-2]
  url = "/api/v1/#{resource}"
  collection = resource.split('/').join('_')

  describe "GET #{url}" do
    let(:action!) { get url }

    after { expect(response.status).to eq(200) }

    xcontext 'empty' do
      let!(:_) { model.destroy_all }

      before { expect(model.count).to be_zero }

      it { action! }

      after { expect(json_response[collection].length).to be_zero }
      after { expect(json_response[collection]).to eq([]) }
      after { expect(model.count).to be_zero }
    end

    context 'not empty' do
      let!(:_) { FactoryGirl.create_list name, 3 }
      let!(:_) { FactoryGirl.create name }
      let!(:count) { model.count }

     let(:expected_records) { serialized_record(entity, model.order('id desc')) }

      before { expect(model.count).to eq(count) }

      it { action! }

      after { expect(json_response[collection]).to eq(expected_records) }
      after { expect(json_response[collection].length).to eq(count) }
      after { expect(model.count).to eq(count) }
    end
  end
end
