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

  it "calculates correct biogas value" do
    calc = Calculation.new
    calc.calc_m3_biogas(95, 100).should == 9500
  end

  it "calculates correct methane value" do 
    calc = Calculation.new
    calc.calc_m3_ch4(9500, 0.6) == 5700
  end

  it "calculates correct methane kg value" do
    calc = Calculation.new
    calc.calc_kg_ch4(5700, 0.73).should == 4161
  end

  it "calculates correct methane gigajoules value" do
    calc = Calculation.new
    calc.calc_gigjoules_ch4(5700, 0.03778).should == 215.35
  end

  it "calculates correct methane mwh value" do
    calc = Calculation.new
    calc.calc_mwh_ch4(215.35, 3.6).should == 59.82
  end

  it "calculates correct digestate volume" do 
    calc = Calculation.new
    calc.calc_digestate_tonnes(300, 0.95).should == 285
  end

  it "calculates correct nitrogen volume" do
    calc = Calculation.new
    calc.calc_digestate_nitrogen(285, 0.005).should == 1.425
  end

  it "calculates correct phosphorus volume" do
    calc = Calculation.new
    calc.calc_digestate_phosphorus(285, 0.0009).should == 0.257
  end

  it "calculates correct potash volume" do
    calc = Calculation.new
    calc.calc_digestate_potash(285, 0.0028).should == 0.798
  end
end
