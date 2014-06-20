require 'spec_helper'

shared_examples 'accountable - logged in - deleted' do |resource, args|

  url = "/api/v1/#{resource}"

  context 'current user user deleted while logged in' do
    before { current_user.destroy }
    it_behaves_like "#{url} - not logged in", args
  end
end
