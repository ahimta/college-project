require 'spec_helper'

describe V1::Applicants do

  describe 'GET /api/v1/applicants' do
    context 'empty' do
      before { get '/api/v1/applicants' }

      it { expect(json_response).to eq({'applicants' => []}) }
      it { expect(response.status).to eq(200) }
    end

    context 'not empty' do
      let!(:records) { FactoryGirl.create_list :applicant, count }
      let(:count) { 3 }

      before { get '/api/v1/applicants' }

      it { expect(json_response).to eq({'applicants' => JSON.parse(Applicant.all.to_json)}) }
      it { expect(json_response['applicants'].length).to eq(count) }
      it { expect(response.status).to eq(200) }
    end
  end
end
