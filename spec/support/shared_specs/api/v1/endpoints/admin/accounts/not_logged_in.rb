require 'spec_helper'

shared_examples '/api/v1/admin/accounts - not_logged_in' do

  url = "/api/v1/admin/accounts"

  context 'allowed' do
  end

  context 'forbidden' do
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
