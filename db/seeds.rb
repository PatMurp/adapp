# preloaded substrate data
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
Feedstock.create!(type: 'Cattle Slurry',
	biogas_per_tonne: 16,
	methane_percent: 0.60,
	digestate_percent: 1)
