require 'spec_helper'

shared_examples '/api/v1/admin/accounts - not_logged_in' do
    resource = 'admin/accounts'
    url = "/api/v1/#{resource}"

    context 'allowed' do
      it_behaves_like 'controllers/login', Admin::Account, resource, Loginable::AdminRole
      it_behaves_like 'controllers/logout', Admin::Account, resource
    end

    context 'forbidden' do
      after { expect(response.status).to eq(401) }

      context 'create' do
        it { post url }
      end
      context 'index' do
        it { get url }
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
end
