require 'spec_helper'

describe API::V1::Applicants do

  args = [Applicant, API::V1::Entities::Applicant, 'applicants']
  factories = {valid: [:applicant], invalid: [:invalid_applicant]}

  it_behaves_like 'controllers/index', *args
  it_behaves_like 'controllers/show', *args
  it_behaves_like 'controllers/destroy', *args
  it_behaves_like 'controllers/create', *args.push(factories)
  it_behaves_like 'controllers/update', *args.push(factories)

  describe 'POST /api/v1/applicants/:id/accept' do
    let!(:rejected_applicant) { FactoryGirl.create(:applicant, accepted: false) }
    let!(:accepted_applicant) { FactoryGirl.create(:applicant, accepted: true) }
    let!(:pending_applicant) { FactoryGirl.create(:applicant) }
    let(:count) { 3 }

    let(:action) { post "/api/v1/applicants/#{record.id}/accept" }

    before { expect(Applicant.count).to eq(count) }
    after { expect(Applicant.count).to eq(count) }

    context 'exist' do
      after { expect(record.reload.accepted).to be(true) }

      context 'rejected' do
        let(:record) { rejected_applicant }

        before { expect(record.reload.accepted).to be(false) }

        it { action }
      end
      context 'accepted' do
        let(:record) { accepted_applicant }

        before { expect(record.reload.accepted).to be(true) }

        it { action }
      end
      context 'pending' do
        let(:record) { pending_applicant }

        before { expect(record.reload.accepted).to be(nil) }

        it { action }
      end
    end
    context 'does not exist' do
      it { post '/api/v1/applicants/99/accept' }

      after { expect(response.status).to eq(404) }
    end
  end
end
