require 'spec_helper'

shared_examples '/api/v1/accountable/username_available' do |resource, role|

  factory = resource.split('/').join('_')[0..-2]
  url = '/api/v1/accountable/username_available'

  describe "HEAD #{url}/username_available" do
    let(:action!) { head "#{url}?username=#{username}&role=#{role}" }
    let(:username) { 'hi' }

    context 'available' do
      it { action! }

      after { expect(response.status).to eq(200) }
    end

    context 'not available' do
      let!(:account) { FactoryGirl.create factory, username: username.swapcase }

      it { action! }

      after { expect(response.status).to eq(409) }
    end
  end
end
