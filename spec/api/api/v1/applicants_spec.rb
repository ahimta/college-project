require 'spec_helper'

describe API::V1::Applicants do

  resource = 'applicants'
  model = Applicant
  name = resource[0..-2]
  url = "/api/v1/#{resource}"

  let(:expected_record) { serialized_record(entity, model.first) }
  let(:entity) { API::V1::Entities::Applicant }

  args = [Applicant, API::V1::Entities::Applicant, 'applicants']
  factories = {valid: [:applicant], invalid: [:invalid_applicant]}

  it_behaves_like 'controllers/index', *args
  it_behaves_like 'controllers/show', *args
  it_behaves_like 'controllers/destroy', *args
  it_behaves_like 'controllers/create', *args.push(factories)
  it_behaves_like 'controllers/update', *args.push(factories)
end
