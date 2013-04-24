require 'spec_helper'

describe "payments/index" do
  before(:each) do
    assign(:payments, [
      stub_model(Payment,
        :order_id => 1,
        :first_name => "First Name",
        :last_name => "",
        :card_type => "",
        :new => "New"
      ),
      stub_model(Payment,
        :order_id => 1,
        :first_name => "First Name",
        :last_name => "",
        :card_type => "",
        :new => "New"
      )
    ])
  end

  it "renders a list of payments" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "New".to_s, :count => 2
  end
end
