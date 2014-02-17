# preloaded substrate data
Substrate.delete_all

Substrate.create!(type: 'Brown Bin',
	biogas_per_tonne: 117,
	methane_percent: 0.55,
	digestate_percent: 0.83)
#...
Substrate.create!(type: 'Grass Silage',
	biogas_per_tonne: 101,
	methane_percent: 0.60,
	digestate_percent: 0.9)
#...
Substrate.create!(type: 'Cattle Slurry',
	biogas_per_tonne: 16,
	methane_percent: 0.60,
	digestate_percent: 1)
