require 'spec_helper'

describe Feedstock do 
	#it "is valid with a type, tonnes, biogas_per_tonne, methane_percent and digestate_percent" do
		#feedstock = Feedstock.new(
			#type: 'grass',
			#tonnes: 59,
			#biogas_per_tonne: 100,
			#methane_percent: 54,
			#digestate_percent: 89)
		#expect(feedstock).to be_valid
	it "has a valid factory" do
		expect(create(:feedstock)).to be_valid
	end

	it "is invalid without a type" do
		expect(build(:feedstock, type: nil)).to have(1).errors_on(:type)
	end

	it "is invalid without a tonnes" do
		expect(build(:feedstock, tonnes: nil)).to have(1).errors_on(:tonnes)
	end

	it "is invalid without a biogas_per_tonne" do
		expect(build(:feedstock, biogas_per_tonne: nil))
		.to have(1).errors_on(:biogas_per_tonne)
	end

	it "is invalid without a methane_percent" do
		expect(build(:feedstock, methane_percent: nil))
		.to have(1).errors_on(:methane_percent)
	end

	it "is invalid without a digestate_percent" do
		expect(build(:feedstock, digestate_percent: nil))
		.to have(1).errors_on(:digestate_percent)
	end

	it "returns a type as a strings" do
		feedstock = FactoryGirl.build(:feedstock,
			type: 'grass', tonnes: 59, biogas_per_tonne: 100, methane_percent: 54,
			digestate_percent: 89)
		expect(feedstock.type). to eq 'grass'
	end

	it "is is invalid with a duplicate type" do
		FactoryGirl.create(:feedstock, type: 'grass', tonnes: 59, biogas_per_tonne: 100, methane_percent: 54,
			digestate_percent: 89)
		feedstock = FactoryGirl.build(:feedstock, type: 'grass', tonnes: 59, biogas_per_tonne: 100, methane_percent: 54,
			digestate_percent: 89)
		expect(feedstock).to have(1).errors_on(:type)
	end

end