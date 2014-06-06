require 'spec_helper'

shared_examples '/api/v1/admin/accounts - logged_in' do |args, create_factories, update_factories|

  it_behaves_like 'controllers/index', *args
  it_behaves_like 'controllers/show', *args
  it_behaves_like 'controllers/destroy', *args
  it_behaves_like 'controllers/create', *(args + [create_factories])
  it_behaves_like 'controllers/update', *(args + [update_factories])
end
