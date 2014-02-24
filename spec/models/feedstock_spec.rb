require 'spec_helper'

describe Feedstock do 
	it "is valid with a type, tonnes, biogas_per_tonne, methane_percent and digestate_percent" do
		feedstock = Feedstock.new(
			type: 'grass',
			tonnes: 59,
			biogas_per_tonne: 100,
			methane_percent: 54,
			digestate_percent: 89)
		expect(feedstock).to be_valid
	end

	it "is invalid without a type" do
		expect(Feedstock.new(type: nil)).to have(1).errors_on(:type)
	end

	it "is invalid without a tonnes" do
		expect(Feedstock.new(tonnes: nil)).to have(1).errors_on(:type)
	end

	it "is invalid without a biogas_per_tonne" do
		expect(Feedstock.new(biogas_per_tonne: nil)).to have(1).errors_on(:type)
	end

	it "is invalid without a methane_percent" do
		expect(Feedstock.new(methane_percent: nil)).to have(1).errors_on(:type)
	end

	it "is invalid without a digestate_percent" do
		expect(Feedstock.new(digestate_percent: nil)).to have(1).errors_on(:type)
	end

	it "returns a type as a strings" do
		feedstock = Feedstock.new(
			type: 'grass', tonnes: 59, biogas_per_tonne: 100, methane_percent: 54,
			digestate_percent: 89)
		expect(feedstock.type). to eq 'grass'
	end

	it "is is invalid with a duplicate type" do
		Feedstock.create(type: 'grass', tonnes: 59, biogas_per_tonne: 100, methane_percent: 54,
			digestate_percent: 89)
		feedstock = Feedstock.new(type: 'grass', tonnes: 59, biogas_per_tonne: 100, methane_percent: 54,
			digestate_percent: 89)
		expect(feedstock).to have(1).errors_on(:type)
	end

end