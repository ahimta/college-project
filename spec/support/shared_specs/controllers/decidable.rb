require 'spec_helper'

shared_examples 'controllers/decidable' do |model, entity, resource|
  
  name = resource[0..-2]
  url = "/api/v1/#{resource}"

  {'accept' => true, 'reject' => false}.each do |decision, accepted|
    describe "POST #{url}/:id/#{decision}" do
      let!(:rejected_record) { FactoryGirl.create(name, accepted: false) }
      let!(:accepted_record) { FactoryGirl.create(name, accepted: true) }
      let!(:pending_record) { FactoryGirl.create(name) }
      
      let(:expected_records) { serialized_record(entity, model.order('id desc').reload) }
      let(:actual_records) { serialized_record(entity, model.all.reload) }
      let(:count) { 3 }

      let(:action) { put "#{url}/#{record.id}/#{decision}" }

      before { expect(actual_records).to eq(expected_records) }
      before { expect(model.count).to eq(count) }

      after { expect(actual_records).to eq(expected_records) }
      after { expect(model.count).to eq(count) }

      context 'exist' do
        after { expect(record.reload.accepted).to be(accepted) }

        context 'rejected' do
          let(:record) { rejected_record }

          before { expect(record.reload.accepted).to be(false) }

          it { action }
        end
        context 'accepted' do
          let(:record) { accepted_record }

          before { expect(record.reload.accepted).to be(true) }

          it { action }
        end
        context 'pending' do
          let(:record) { pending_record }

          before { expect(record.reload.accepted).to be(nil) }

          it { action }
        end
      end
      context 'does not exist' do
        it { put "#{url}/99/#{decision}" }

        after { expect(response.status).to eq(404) }
      end
    end
  end
end
