require 'spec_helper'

shared_examples '/api/v1/applicant/job_requests - logged in as a recruiter' do |args, factories|

  resource = 'applicant/job_requests'

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [factories])
    it_behaves_like 'controllers/update', *(args + [factories])

    it_behaves_like 'controllers/decidable', *args
  end

  context 'current user user deleted while logged in' do
    it_behaves_like 'accountable - logged in - deleted', resource
  end
end
