require 'spec_helper'

describe V1::Applicants do

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

  describe 'POST /api/v1/applicants' do
    let(:action) { post '/api/v1/applicants', params }

    before { expect(Applicant.count).to be_zero }

    context 'valid' do
      let(:params) { {applicant: FactoryGirl.attributes_for(:applicant)} }

      it { action }

      after { expect(json_response).to eq({'applicant' => JSON.parse(Applicant.first.to_json)}) }
      after { expect(response.status).to eq(201) }
      after { expect(Applicant.count).to eq(1) }
    end

    context 'invalid' do
      let(:params) { {applicant: FactoryGirl.attributes_for(:invalid_applicant)} }
      let(:errors) {
        applicant = Applicant.new params[:applicant]
        applicant.valid?
        {'errors' => JSON.parse(applicant.errors.to_json)}
      }

      it { action }

      after { expect(json_response).to eq(errors) }
      after { expect(response.status).to eq(400) }
      after { expect(Applicant.count).to be_zero }
    end
  end
end
