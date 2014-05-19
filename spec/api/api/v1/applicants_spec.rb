require 'spec_helper'

describe API::V1::Applicants do

  resource = 'applicants'
  model = Applicant
  name = resource[0..-2]
  url = "/api/v1/#{resource}"

  let(:expected_record) { serialized_record(entity, model.first) }
  let(:entity) { API::V1::Entities::Applicant }

  describe "GET #{url}" do
    let(:action) { get url }
    
    before { expect(model.count).to be_zero }

    context 'empty' do
      it { action }

      after { expect(json_response).to eq(serialized_record(entity, model.all)) }
      after { expect(json_response[resource].length).to be_zero }
      after { expect(response.status).to eq(200) }
      after { expect(model.count).to be_zero }
    end

    context 'not empty' do
      let(:expected_records) { serialized_record(entity, model.order('id')) }
      let!(:records) { FactoryGirl.create_list name, count }
      let(:count) { 3 }

      it { action }

      after { expect(json_response[resource].length).to eq(count) }
      after { expect(json_response).to eq(expected_records) }
      after { expect(model.count).to eq(count) }
      after { expect(response.status).to eq(200) }
    end
  end

  describe "GET #{url}/:id" do
    context 'exists' do
      let!(:record) { FactoryGirl.create :applicant }

      it { get "#{url}/#{record.id}" }

      after { expect(json_response).to eq(expected_record) }
      after { expect(response.status).to eq(200) }
    end
    context 'does not exist' do
      it { get "#{url}/99" }

      after { expect(response.status).to eq(404) }
    end
  end

  describe "POST #{url}" do
    let(:action) { post url, params }

    before { expect(model.count).to be_zero }

    context 'valid' do
      let(:params) {
        {name => FactoryGirl.attributes_for(name).update(xyz: 'hi') }
      }

      it { action }

      after { expect(json_response).to eq(expected_record) }
      after { expect(response.status).to eq(201) }
      after { expect(model.count).to eq(1) }
    end

    context 'invalid' do
      let(:params) { {name => FactoryGirl.attributes_for(:invalid_applicant)} }

      it { action }

      after { expect(response.status).to eq(400) }
      after { expect(model.count).to be_zero }
    end
  end

  describe "PUT #{url}/:id" do
    let(:action) { put "#{url}/#{record.id}", params }
    let!(:record) { FactoryGirl.create name }
    let(:count) { 1 }

    before { expect(model.count).to eq(count) }
    after { expect(model.count).to eq(count) }

    context 'does not exist' do
      it { put "#{url}/99", {name => FactoryGirl.attributes_for(name)} }

      after { expect(response.status).to eq(404) }
    end

    context 'valid' do
      let(:params) { { applicant: FactoryGirl.attributes_for(name).update(xyz: 'aa') } }

      it { action }

      after { expect(model.first.attributes.to_s).to_not eq(record.attributes.to_s) }
      after { expect(json_response).to eq(expected_record) }
      after { expect(response.status).to eq(200) }
    end

    context 'invalid' do
      let(:params) { { name => FactoryGirl.attributes_for(:invalid_applicant) } }
      
      it { action }

      after { expect(model.first.attributes.to_s).to eq(record.attributes.to_s) }
      after { expect(response.status).to eq(400) }
    end
  end

  describe "DELETE #{url}/:id" do
    let!(:record) { FactoryGirl.create name }
    let(:count) { 1 }

    before { expect(model.count).to eq(1) }

    context 'exist' do
      it { delete "#{url}/#{record.id}" }

      after { expect(json_response).to eq(serialized_record(entity, record)) }
      after { expect(model.count).to be_zero }
    end

    context 'does not exist' do
      it { delete "#{url}/99" }

      after { expect(response.status).to eq(404) }
    end
  end
end
