require 'spec_helper'

describe Calculation do

	it { should belong_to(:feedstock) }

  it "has a valid factory" do
  	expect(create(:calculation)).to be_valid
  end

  it "is invalid without a feedstock_id" do
  	expect(build(:calculation, feedstock_id: nil)).
  	to have(1).errors_on(:feedstock_id)
  end

  it "is invalid without a tonnes" do
  	expect(build(:calculation, tonnes: nil)).
  	to have(1).errors_on(:tonnes)
  end

end
