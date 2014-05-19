require 'spec_helper'

describe API::V1::Applicants do

  args = [Applicant, API::V1::Entities::Applicant, 'applicants']
  factories = {valid: [:applicant], invalid: [:invalid_applicant]}

  it_behaves_like 'controllers/index', *args
  it_behaves_like 'controllers/show', *args
  it_behaves_like 'controllers/destroy', *args
  it_behaves_like 'controllers/create', *args.push(factories)
  it_behaves_like 'controllers/update', *args.push(factories)

  it_behaves_like 'controllers/decidable', *args
end
