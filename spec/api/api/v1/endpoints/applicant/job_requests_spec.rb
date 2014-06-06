require 'spec_helper'

describe API::V1::Endpoints::Applicant::JobRequests do

  resource = 'applicant/job_requests'
  url = "/api/v1/#{resource}"

  args = [Applicant::JobRequest, API::V1::Entities::Applicant::JobRequest, resource]
  factories = {valid: [:applicant_job_request], invalid: [:invalid_applicant_job_request]}

  context 'logged in' do
    let!(:_admin) { FactoryGirl.create :admin_account }
    let!(:_login) { {login: {username: _admin.username, password: _admin.password}} }

    before { post '/api/v1/admin/accounts/login', _login }

    it_behaves_like "#{url} - logged_in", args, factories
  end

  context 'not logged in' do
    it_behaves_like "#{url} - not_logged_in", (args + [factories])
  end
end
