require 'spec_helper'

describe AuthUser do
  let(:user) { AuthUser.create(:name => "Maks", :email => 'maks@test.com') }

  it "should have a name and email" do
    user.name.should == "Maks"
    user.email.should == 'maks@test.com'
  end
  it { should respond_to(:name) }
  it { should respond_to(:email) }


  let(:auth_hash) {{ 'provider' => 'facebook', 'uid' => '123456' }}
  it ' Should add provider from auth hash' do
    expect { user.add_provider(auth_hash) }.to change { Authorization.count }.by(1)
  end
end
