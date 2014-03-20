# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calculation do
  	feedstock_id 1
  	project_id 1
  	tonnes 500

  	factory :invalid_calculation do
  		feedstock_id 1
  		tonnes nil
  	end
  end
end
