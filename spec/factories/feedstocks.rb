
FactoryGirl.define do 
	factory :feedstock do
		sequence(:type)	{|n|"silage #{n}" }
		tonnes 500
		biogas_per_tonne	95
		methane_percent	65
		digestate_percent 85
	

		factory :invalid_feedstock do
			tonnes nil
		end
	end
end