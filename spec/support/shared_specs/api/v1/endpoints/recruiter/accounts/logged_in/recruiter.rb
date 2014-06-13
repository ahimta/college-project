require 'spec_helper'

shared_examples '/api/v1/recruiter/accounts - logged_in as a recruiter' do |args, create_factories, update_factories|

  url = '/api/v1/recruiter/accounts'

  context 'allowed' do
  end

  context 'not allowed' do
    after { expect(response.status).to eq(401) }

    context 'index' do
      it { get url }
    end
    context 'show' do
      it { get "#{url}/99" }
    end
    context 'create' do
      it { post url }
    end
    context 'update' do
      it { put "#{url}/99" }
    end
    context 'destroy' do
      it { delete "#{url}/99" }
    end
  end
end
