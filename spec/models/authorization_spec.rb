require 'spec_helper'

describe Authorization do

  let(:authorization) {Authorization.create(:uid => '123456', :provider => 'twitter')}
  let(:auth_hash) {{ 'info' => { 'name' => 'Maks', 'email' => 'maks@test.com'}, 'provider' => 'twitter', 'uid' => '123456' }}

  it 'should have uid and provider' do
    authorization.uid.should == '123456'
    authorization.provider.should == 'twitter'
  end

  it 'should create new authorization from auth_hash' do
    expect { Authorization.create_(auth_hash) }.to change {User.count}.by(1)
    User.find_by_name('Maks').should_not be_nil

  end

end
