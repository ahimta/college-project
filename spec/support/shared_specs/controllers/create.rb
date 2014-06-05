require 'spec_helper'

shared_examples 'controllers/create' do |model, entity, resource, factories|

  name = resource.split('/').join('_')[0..-2]
  url = "/api/v1/#{resource}"

  describe "POST #{url}" do
    let!(:old_count) { model.count }
    let(:action) { post url, params }

    before { expect(model.count).to eq(old_count) }

    context 'valid' do
      let(:expected_record) { serialized_record(entity, model.first) }

      factories[:valid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action }

        after { expect(json_response).to eq(expected_record) }
        after { expect(response.status).to eq(201) }
        after { expect(model.count).to eq(old_count + 1) }
      end
    end

    context 'invalid' do
      factories[:invalid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action }

        after { expect(response.status).to eq(400) }
        after { expect(model.count).to eq(old_count) }
      end
    end
  end
end
