require 'spec_helper'

shared_examples 'controllers/update' do |model, entity, resource, factories|

  name = resource.split('/').join('_')[0..-2]
  url = "/api/v1/#{resource}"

  describe "PUT #{url}/:id" do
    let!(:record) { FactoryGirl.create name }
    let!(:count) { model.count }

    let(:action!) { put "#{url}/#{record.id}", params }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'does not exist' do
      it { put "#{url}/99", generate_params(name, name) }

      after { expect(response.status).to eq(404) }
    end

    context 'valid' do
      let(:expected_record) { serialized_record(entity, model.first) }

      factories[:valid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action! }

        # order matters record.attributes first then record.reload.attributes
        after { expect(record.attributes.to_s).to_not eq(record.reload.attributes.to_s) }
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
