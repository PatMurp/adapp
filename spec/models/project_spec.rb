require 'spec_helper'

describe Project do

	it { should belong_to(:user) }

	it { should have_many(:calculations) }

  it "has a valid factory" do
  	expect(create(:project)).to be_valid
  end

  it "is invalid without a name" do
  	expect(build(:project, name: nil)).
  	to have(1).errors_on(:name)
  end

  it "calculates correct CHP usable heat" do
  	proj = Project.new
  	proj.chp_usable_heat(10000, 0.5) == 5000
  end

  it "calculates correct CHP salable heat" do
  	proj = Project.new
  	proj.chp_salable_heat(10000, 0.5) == 5000
  end

  it "calculates correct co2 savings from CHP heat" do
  	proj = Project.new
  	proj.calc_carbon_savings_from_chp_heat(5000, 1.5, 0.5) == 3750
  end

  it "calculates correct income potential  CHP heat" do
  	proj = Project.new
  	proj.calc_potential_income_heat(2000, 96) == 192000
  end

  it "calculates correct CHP usable electricity" do
  	proj = Project.new
  	proj.chp_potential_elec(30000, 0.3) == 9000
  end

  it "calculates correct CHP salable Electriciy" do
  	proj = Project.new
  	proj.chp_salable_elec(9000, 0.8) == 7200
  end

  it "calculates correct co2 savings from CHP electriciy" do
  	proj = Project.new
  	proj.calc_carbon_savings_from_chp_elec(20000, 2.7, 0.643) == 34722
  end

  it "calculates correct co2 savings CHP combined" do
  	proj = Project.new
  	proj.calc_carbon_savings_from_chp_combined(1234, 5674) == 6908
  end

  it "calculates correct CHP generator size" do
  	proj = Project.new
  	proj.calc_generator_size(10000, 364) == 27.473
  end

  it "calculates correct income potential CHP electricity" do
  	proj = Project.new
  	proj.calc_potential_income_elec(1000, 1.5) == 1500
  end

  it "calculates correct total potential income from CHP" do
  	proj = Project.new
  	proj.calc_total_potential_income_chp(234.53, 127.2) == 361.73
  end

  it "calculates correct upgrading energy consumption" do
  	proj = Project.new
  	proj.calc_upg_energy_consump(2345, 0.00315) == 7.39
  end

  it "calculates correct upgrading methane loss" do
  	proj = Project.new
  	proj.calc_upg_ch4_loss(3000, 0.0335) == 100.5
  end

  it "calculates correct upgraded methane volume" do
  	proj = Project.new
  	proj.calc_upg_ch4(7000, 23.32) == 6976.68
  end

  it "calculates correct upgraded gigajoules" do
  	proj = Project.new
  	proj.calc_upg_gigjoules_ch4(3000, 0.03778) == 113.34
  end

  it "calculates correct upgraded methaner per hour" do
  	proj = Project.new
  	proj.calc_upg_ch4_per_hour(5000, 8736) == 0.57
  end

  it "calculates correct upgrading potential vehicle value" do
  	proj = Project.new
  	proj.calc_potential_upg_income_vehicle()
  end

  it "calculates correct potential buses fueled" do
  	proj = Project.new
  	proj.calc_potential_buses_fueled(30000, 27500) == 1.1
  end

  it "calculates correct potential waste trucks fueled" do
  	proj = Project.new
  	proj.calc_potential_wtruck_fueled(76000, 35750) == 2.1
  end

  it "calculates correct potential cars fueled" do
  	proj = Project.new
  	proj.calc_potential_cars_fueled(3333, 1035) == 3.2
  end

  it "calculates correct upgraded therms" do
  	proj = Project.new
  	proj.calc_upg_therms(3000, 9.4781708) == 28434.51
  end

  it "calculates correct potential gas grid value" do
  	proj = Project.new
  	proj.calc_potential_gas_grid_income(3000, 0.96) == 2880
  end

  it "calculates correct potential mwh upgraded" do
  	proj = Project.new
  	proj.calc_upg_mwh_ch4(3300, 3.6) == 11880
  end

  it "calculates correct potential homes fueled" do
  	proj = Project.new
  	proj.calc_potential_homes_fueled(55, 13.8) == 4
  end

  it "calculates correct co2 savings from gas grid" do
  	proj = Project.new
  	proj.calc_carbon_savings_from_upg_ggrid(750, 1.1, 0.203) == 167.48
  end

  it "calculates correct co2 savings from vehicle diesel" do
  	proj = Project.new
  	proj.calc_carbon_savings_from_upg_diesel(700, 0.2938, 0.78) == 160.42
  end

end
