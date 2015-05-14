require 'rails_helper'

describe User do
  before { @user = FactoryGirl.create(:user) }
  subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should respond_to(:parcels) }

  it { should be_valid }
  it { should_not be_notify }

  describe "parcels associations" do

    # before { @user.save }
    let!(:older_parcel) do
      FactoryGirl.create(:parcel, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_parcel) do
      FactoryGirl.create(:parcel, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right parcels in the right order" do
      expect(@user.parcels.to_a).to eq [newer_parcel, older_parcel]
    end

    it "should destroy associated parcels" do
      parcels = @user.parcels.to_a
      @user.destroy
      expect(parcels).not_to be_empty
      parcels.each do |parcel|
        expect(Parcel.where(id: parcel.id)).to be_empty
      end
    end

    describe "only own parcels" do
      let(:foreign_parcel) do
        FactoryGirl.create(:parcel, user: FactoryGirl.create(:user))
      end

      it{ expect(subject.parcels).to include(newer_parcel)}
      it{ expect(subject.parcels).to include(older_parcel)}
      it{ expect(subject.parcels).not_to include(foreign_parcel)}
    end
  end
end
