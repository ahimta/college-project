require 'spec_helper'

shared_examples 'controllers/show' do |model, entity, resource|

  name = resource.split('/').join('_')[0..-2]
  url = "/api/v1/#{resource}"

  describe "GET #{url}/:id" do
    context 'exists' do
      let(:expected_record) { serialized_record(entity, record) }
      let!(:record) { FactoryGirl.create name }

      it { get "#{url}/#{record.id}" }

      after { expect(json_response[name]).to eq(expected_record) }
      after { expect(response.status).to eq(200) }
    end
    context 'does not exist' do
      it { get "#{url}/99" }

      after { expect(response.status).to eq(404) }
    end
  end
end
