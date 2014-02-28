# preloaded feedstock data
Feedstock.delete_all

Feedstock.create!(type: 'Brown Bin',
	biogas_per_tonne: 117,
	methane_percent: 0.55,
	digestate_percent: 0.83)
#...
Feedstock.create!(type: 'Grass Silage',
	biogas_per_tonne: 101,
	methane_percent: 0.60,
	digestate_percent: 0.9)
#...
Feedstock.create!(type: 'Fresh Grass',
	biogas_per_tonne: 75,
	methane_percent: 0.61,
	digestate_percent: 0.9)
#...
Feedstock.create!(type: 'Cattle Slurry',
	biogas_per_tonne: 16,
	methane_percent: 0.60,
	digestate_percent: 1)
#...
Feedstock.create!(type: 'Paunch Waste',
	biogas_per_tonne: 67,
	methane_percent: 0.55,
	digestate_percent: 0.9)
#...
Feedstock.create!(type: 'Grease Trap',
	biogas_per_tonne: 295,
	methane_percent: 0.50,
	digestate_percent: 1)
#...
Feedstock.create!(type: 'Vegetable Oil',
	biogas_per_tonne: 697,
	methane_percent: 0.58,
	digestate_percent: 1)
#...
Feedstock.create!(type: 'WWTP Sludge',
	biogas_per_tonne: 26,
	methane_percent: 0.65,
	digestate_percent: 1)
#...
Feedstock.create!(type: 'Glycerine',
	biogas_per_tonne: 728,
	methane_percent: 0.50,
	digestate_percent: 1)
#...
Feedstock.create!(type: 'Pig Slurry',
	biogas_per_tonne: 25,
	methane_percent: 0.55,
	digestate_percent: 1)
