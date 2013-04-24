require 'spec_helper'

describe "payments/show" do
  before(:each) do
    @payment = assign(:payment, stub_model(Payment,
      :order_id => 1,
      :first_name => "First Name",
      :last_name => "",
      :card_type => "",
      :new => "New"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/First Name/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/New/)
  end
end
