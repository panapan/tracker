require 'rails_helper'

describe Track do

  let(:user) { FactoryGirl.create(:user) }
  let(:parcel) {FactoryGirl.create(:parcel, user: user)}
  before do
    @track = parcel.tracks.build(event: "Test")
  end

  subject { @track }

  it { should respond_to(:track_id) }
  it { should respond_to(:date_time) }
  it { should respond_to(:geo) }
  it { should respond_to(:event) }

  it { should respond_to(:parcel_id) }
  it { should respond_to(:parcel) }
  it { expect(subject.parcel).to eq parcel }
  it { should be_valid }

  describe "when parcel_id is not present" do
    before { @track.parcel_id = nil }
    it { should_not be_valid }
  end

  # describe "without track_id" do
  #   before { @track.track_id = nil }
  #   it { should_not be_valid }
  # end
end
