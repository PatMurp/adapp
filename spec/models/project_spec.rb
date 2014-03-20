require 'spec_helper'

describe Project do

	it { should have_many(:calculations) }

  it "has a valid factory" do
  	expect(create(:project)).to be_valid
  end

  it "is invalid without a name" do
  	expect(build(:project, name: nil)).
  	to have(1).errors_on(:name)
  end
end
