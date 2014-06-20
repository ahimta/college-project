require 'spec_helper'

shared_examples 'accountable - logged in - deleted' do |resource|

  url = "/api/v1/#{resource}"

  context 'current user user deleted while logged in' do
    let!(:_) { current_user.destroy }

    it_behaves_like "#{url} - not logged in"
  end
end
