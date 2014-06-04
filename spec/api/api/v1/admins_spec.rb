require 'spec_helper'

describe API::V1::Admins do

  args = [Admin, API::V1::Entities::Admin, 'admins']
  create_factories = {
    valid: [
      :admin_with_correct_password_confirmation,
      :admin
    ],
    invalid: [
      :admin_with_incorrect_password_confirmation,
      :admin_without_full_name,
      :admin_without_username,
      :admin_without_password
    ]
  }

  update_factories = {
    invalid: (create_factories[:invalid] - [:admin_without_password]),
    valid: (create_factories[:valid] + [:admin_without_password])
  }

  it_behaves_like 'controllers/login', Admin, 'admins'

  context 'logged in' do
    it_behaves_like 'controllers/index', *args
    it_behaves_like 'controllers/show', *args
    it_behaves_like 'controllers/destroy', *args
    it_behaves_like 'controllers/create', *(args + [create_factories])
    it_behaves_like 'controllers/update', *(args + [update_factories])
  end

  context 'not logged in' do

  end
end
