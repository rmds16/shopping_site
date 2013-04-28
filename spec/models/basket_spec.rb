require 'spec_helper'

describe Basket do
  before do
    @basket = Basket.create
  end

  subject { @basket }

  it { should be_valid }

end
