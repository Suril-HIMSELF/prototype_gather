class_name Utils extends Node


static func get_total_ore_weight() -> float:
	var total = 0
	
	total += Data.ORE_WEIGHT[Data.ORE.STONE]
	total += Data.ORE_WEIGHT[Data.ORE.IRON]
	total += Data.ORE_WEIGHT[Data.ORE.GOLD]
	total += Data.ORE_WEIGHT[Data.ORE.SAPPHIRE]
	total += Data.ORE_WEIGHT[Data.ORE.RUBY]
	total += Data.ORE_WEIGHT[Data.ORE.EMERALD]
	total += Data.ORE_WEIGHT[Data.ORE.DIAMOND]
	
	return total


static func roll_ore() -> int:
	var total = get_total_ore_weight()
	var rdm = randf() * total
	var cumulative = 0
	
	for ore in Data.ORE_WEIGHT:
		cumulative += Data.ORE_WEIGHT[ore]
		
		if rdm <= cumulative:
			return ore
	
	return 0
