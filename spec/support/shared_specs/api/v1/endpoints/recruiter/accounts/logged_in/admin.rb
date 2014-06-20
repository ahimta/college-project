require 'spec_helper'

shared_examples '/api/v1/recruiter/accounts - logged in as an admin' do |args, create_factories, update_factories|

  resource = 'recruiter/accounts'
  model = Recruiter::Account

  context 'allowed' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])
    it_behaves_like 'controllers/destroy', *args

    it_behaves_like 'controllers/accountable/create', model, resource
  end

  context 'not allowed' do
  end

  context 'current user user deleted while logged in' do
    it_behaves_like 'accountable - logged in - deleted', resource
  end
end
