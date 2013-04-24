require 'spec_helper'

describe "payments/new" do
  before(:each) do
    assign(:payment, stub_model(Payment,
      :order_id => 1,
      :first_name => "MyString",
      :last_name => "",
      :card_type => "",
      :new => "MyString"
    ).as_new_record)
  end

  it "renders new payment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => payments_path, :method => "post" do
      assert_select "input#payment_order_id", :name => "payment[order_id]"
      assert_select "input#payment_first_name", :name => "payment[first_name]"
      assert_select "input#payment_last_name", :name => "payment[last_name]"
      assert_select "input#payment_card_type", :name => "payment[card_type]"
      assert_select "input#payment_new", :name => "payment[new]"
    end
  end
end
