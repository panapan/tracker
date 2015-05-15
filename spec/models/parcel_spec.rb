require 'rails_helper'

describe Parcel do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @parcel = user.parcels.build(num: "123456789ABCD")
  end

  subject { @parcel }

  it { should respond_to(:num) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { expect(subject.user).to eq user }
  it { should respond_to(:tracks) }


  it { should be_valid }

  describe "when user_id is not present" do
    before { @parcel.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank num" do
    before { @parcel.num = " " }
    it { should_not be_valid }
  end
end
