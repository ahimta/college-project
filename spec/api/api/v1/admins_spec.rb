require 'spec_helper'

describe API::V1::Admins do

  args = [Admin, API::V1::Entities::Admin, 'admins']
  factories = {valid: [:admin], invalid: []}

  it_behaves_like 'controllers/index', *args
  it_behaves_like 'controllers/show', *args
  it_behaves_like 'controllers/destroy', *args
  it_behaves_like 'controllers/create', *args.push(factories)
  it_behaves_like 'controllers/update', *args.push(factories)
end
