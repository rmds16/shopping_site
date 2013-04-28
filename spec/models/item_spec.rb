require 'spec_helper'

describe Item do
  before do
    @item = FactoryGirl.create(:item)
  end

  subject { @item }
 
  it { should respond_to(:description) }
  it { should respond_to(:name) }
  it { should respond_to(:price) }

  it { should be_valid }
 
  describe "when description is not present" do
    before { @item.description = " "}
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @item.name = " "}
    it { should_not be_valid }
  end

  describe "when price is not present" do
    before { @item.price = " "}
    it { should_not be_valid }
  end
end
