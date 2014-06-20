require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged in as a recruiter' do |args, create_factories, update_factories|

  resource = 'admin/accounts'
  url = "/api/v1/#{resource}"

  context 'allowed' do
  end

  context 'not allowed' do
    after { expect(response.status).to eq(401) }

    context 'index' do
      it { get url }
    end
    context 'create' do
      it { post url }
    end
    context 'show' do
      it { get "#{url}/99" }
    end
    context 'update' do
      it { put "#{url}/99" }
    end
    context 'destroy' do
      it { delete "#{url}/99" }
    end
  end

  context 'current user user deleted while logged in' do
    it_behaves_like 'accountable - logged in - deleted', resource
  end
end
