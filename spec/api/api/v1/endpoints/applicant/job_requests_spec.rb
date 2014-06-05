require 'spec_helper'

describe API::V1::Endpoints::Applicant::JobRequests do

  args = [Applicant, API::V1::Entities::Applicant, 'applicants', :applicant]
  factories = {valid: [:applicant], invalid: [:invalid_applicant]}

  it_behaves_like 'controllers/index', *args
  it_behaves_like 'controllers/show', *args
  it_behaves_like 'controllers/destroy', *args
  it_behaves_like 'controllers/create', *(args + [factories])
  it_behaves_like 'controllers/update', *(args + [factories])

  it_behaves_like 'controllers/decidable', *args
end
