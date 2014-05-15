require 'spec_helper'

describe API::V1::Applicants do

  describe 'GET /api/v1/applicants' do
    let(:action) { get '/api/v1/applicants' }
    
    before { expect(Applicant.count).to be_zero }

    context 'empty' do
      it { action }

      after { expect(json_response).to eq({'applicants' => []}) }
      after { expect(response.status).to eq(200) }
      after { expect(Applicant.count).to be_zero }
    end

    context 'not empty' do
      let!(:records) { FactoryGirl.create_list :applicant, count }
      let(:count) { 3 }

      it { action }

      after { expect(json_response).to eq({'applicants' => JSON.parse(Applicant.all.to_json)}) }
      after { expect(json_response['applicants'].length).to eq(count) }
      after { expect(Applicant.count).to eq(count) }
      after { expect(response.status).to eq(200) }
    end
  end

  describe 'GET /api/v1/applicants/:id' do
    context 'exists' do
      let!(:record) { FactoryGirl.create :applicant }

      it { get "/api/v1/applicants/#{record.id}" }

      after { expect(json_response).to eq({'applicant' => JSON.parse(Applicant.first.to_json)})}
      after { expect(response.status).to eq(200) }
    end
    context 'does not exist' do
      it { get '/api/v1/applicants/99' }

      after { expect(response.status).to eq(404) }
    end
  end

  describe 'POST /api/v1/applicants' do
    let(:action) { post '/api/v1/applicants', params }

    before { expect(Applicant.count).to be_zero }

    context 'valid' do
      after { expect(Applicant.count).to eq(1) }

      context 'valid attributes' do
        let(:params) { {applicant: FactoryGirl.attributes_for(:applicant)} }

        it { action }

        after { expect(json_response).to eq({'applicant' => JSON.parse(Applicant.first.to_json)}) }
        after { expect(response.status).to eq(201) }
      end

      context 'with unsupported' do
        let(:params) {
          {applicant: FactoryGirl.attributes_for(:applicant).update(xyz: 'hi') }
        }

        it { action }

        after { expect(json_response).to eq({'applicant' => JSON.parse(Applicant.first.to_json)}) }
        after { expect(response.status).to eq(201) }
      end
    end

    context 'invalid' do
      after { expect(Applicant.count).to be_zero }

      context 'values' do
        let(:params) { {applicant: FactoryGirl.attributes_for(:invalid_applicant)} }

        it { action }

        after { expect(response.status).to eq(400) }
      end
    end
  end

  describe 'PUT /api/v1/applicants/:id' do
    let(:action) { put "/api/v1/applicants/#{record.id}", params }
    let!(:record) { FactoryGirl.create :applicant }
    let(:count) { 1 }

    before { expect(Applicant.count).to eq(count) }
    after { expect(Applicant.count).to eq(count) }

    context 'does not exist' do
      it { put '/api/v1/applicants/99', {applicant: FactoryGirl.attributes_for(:applicant)} }

      after { expect(response.status).to eq(404) }
    end

    context 'valid' do
      let(:params) { { applicant: FactoryGirl.attributes_for(:applicant).update(xyz: 'aa') } }

      it { action }

      after { expect(json_response).to eq({'applicant' => JSON.parse(Applicant.first.to_json)}) }
      after { expect(Applicant.first.attributes.to_s).to_not eq(record.attributes.to_s) }
      after { expect(response.status).to eq(200) }
    end

    context 'invalid' do
      let(:params) { { applicant: FactoryGirl.attributes_for(:invalid_applicant) } }
      
      it { action }

      after { expect(Applicant.first.attributes.to_s).to eq(record.attributes.to_s) }
      after { expect(response.status).to eq(400) }
    end
  end
end
