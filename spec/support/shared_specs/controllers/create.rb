require 'spec_helper'

shared_examples 'controllers/create' do |model, entity, resource, factories|
  
  name = resource[0..-2]
  url = "/api/v1/#{resource}"

  describe "POST #{url}" do
    let(:action) { post url, params }

    before { expect(model.count).to be_zero }

    context 'valid' do
      factories[:valid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action }

        after { expect(json_response).to eq(expected_record) }
        after { expect(response.status).to eq(201) }
        after { expect(model.count).to eq(1) }
      end
    end

    context 'invalid' do
      factories[:invalid].each do |factory|
        let(:params) { generate_params(factory, name) }

        it { action }

        after { expect(response.status).to eq(400) }
        after { expect(model.count).to be_zero }
      end
    end
  end
end
