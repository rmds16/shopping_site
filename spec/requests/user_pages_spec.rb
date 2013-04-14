require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Register') }
    it { should have_selector('title', text: 'Register') }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) { "Register" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Richard da Silva"
        fill_in "Email", with: "richard@da-silva.me.uk"
        fill_in "Password", with: "foobar"
        fill_in "Password confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('richard@da-silva.me.uk') }

        it { should have_link('Sign out') }

        describe "followed by signout" do
          before { click_link 'Sign out' }
          it { should have_link('Sign in') }

          describe "signin page" do
            before do
              click_link 'Sign in' 
              fill_in "Email", with: "richard@da-silva.me.uk"
              fill_in "Password", with: "foobar"
              click_button "Login"
            end
            it { should have_selector('title', text: 'Richard da Silva') }
          end
        end
      end
    end
  end
 
end
