require 'spec_helper'

describe Address do
  before do
    @address = FactoryGirl.build(:address)
    @user = FactoryGirl.create(:user)
    @address.user = @user
  end

  subject { @address }
 
  it { should respond_to(:user_id) }
  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:building) }
  it { should respond_to(:street) }
  it { should respond_to(:county) }
  it { should respond_to(:post_code) }
  it { should respond_to(:town) }
  it { should respond_to(:country) }
  it { should respond_to(:phone) }

  it { should be_valid }
 
  describe "when first_name is not present" do
    before { @address.first_name = " "}
    it { should_not be_valid }
  end

  describe "when last_name is not present" do
    before { @address.last_name = " "}
    it { should_not be_valid }
  end

  describe "when building is not present" do
    before { @address.last_name = " "}
    it { should_not be_valid }
  end

  describe "when street is not present" do
    before { @address.street = " "}
    it { should_not be_valid }
  end

  describe "when county is not present" do
    before { @address.county = " "}
    it { should_not be_valid }
  end

  describe "when post_code is not present" do
    before { @address.post_code = " "}
    it { should_not be_valid }
  end

  describe "when town is not present" do
    before { @address.town = " "}
    it { should_not be_valid }
  end

  describe "when country is not present" do
    before { @address.country = " "}
    it { should_not be_valid }
  end

  describe "when post code is invalid" do
    it "should be invalid" do
      post_codes = ["AAA 3ZZ", "TH1 44H", "AAAAAAA", "0000000"]
      post_codes.each do |post_code|
        @address.post_code = post_code
        @address.should_not be_valid
      end
    end
  end

  describe "when post code is valid" do
    it "should be valid" do
      post_codes = ["AA1 1ZZ", "aa1 1zz", "aa1 1ZZ", "TH11 4HH", "AA11ZZ", "TH114HH"]
      post_codes.each do |post_code|
        @address.post_code = post_code
        @address.should be_valid
      end
    end
  end

  describe "when phone number is valid" do
    it "should be valid" do
      phone_numbers = ["11111111111", "01438 111111", "01438111111", "+441111111111"]
      phone_numbers.each do |phone|
        @address.phone = phone
        @address.should be_valid
      end
    end
  end

  describe "when phone number is invalid" do
    it "should be invalid" do
      phone_numbers = ["AAA11111111", "01438-111111", "(01438)111*&1"]
      phone_numbers.each do |phone|
        @address.phone = phone
        @address.should_not be_valid
      end
    end
  end
end
