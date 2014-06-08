require 'spec_helper'

shared_examples 'controllers/destroy' do |model, entity, resource|

  name = resource.split('/').join('_')[0..-2]
  url = "/api/v1/#{resource}"

  describe "DELETE #{url}/:id" do
    let(:expected_record) { serialized_record(entity, record) }
    let!(:record) { FactoryGirl.create name }
    let!(:count) { model.count }

    before { expect(model.count).to eq(count) }

    context 'exist' do
      it { delete "#{url}/#{record.id}" }

      after { expect(json_response[name]).to eq(expected_record) }
      after { expect(model.count).to eq(count - 1) }
    end

    context 'does not exist' do
      it { delete "#{url}/99" }

      after { expect(response.status).to eq(404) }
      after { expect(model.count).to eq(count) }
    end
  end
end
