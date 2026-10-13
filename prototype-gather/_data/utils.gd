class_name Utils extends Node


static func get_total_ore_mine_weight() -> float:
	var total = 0
	
	total += Data.ORE_MINE_WEIGHT[Data.ORE_MINE.STONE]
	total += Data.ORE_MINE_WEIGHT[Data.ORE_MINE.GOLD]
	total += Data.ORE_MINE_WEIGHT[Data.ORE_MINE.SAPPHIRE]
	total += Data.ORE_MINE_WEIGHT[Data.ORE_MINE.RUBY]
	total += Data.ORE_MINE_WEIGHT[Data.ORE_MINE.EMERALD]
	total += Data.ORE_MINE_WEIGHT[Data.ORE_MINE.DIAMOND]
	
	return total


static func get_total_ore_quarry_weight() -> float:
	var total = 0
	
	total += Data.ORE_QUARRY_WEIGHT[Data.ORE_QUARRY.STONE]
	total += Data.ORE_QUARRY_WEIGHT[Data.ORE_QUARRY.IRON]
	total += Data.ORE_QUARRY_WEIGHT[Data.ORE_QUARRY.COPPER]
	total += Data.ORE_QUARRY_WEIGHT[Data.ORE_QUARRY.BRONZE]
	total += Data.ORE_QUARRY_WEIGHT[Data.ORE_QUARRY.SILVER]
	
	return total


static func roll_ore_mine() -> int:
	var total = get_total_ore_mine_weight()
	var rdm = randf() * total
	var cumulative = 0
	
	for ore in Data.ORE_MINE_WEIGHT:
		cumulative += Data.ORE_MINE_WEIGHT[ore]
		
		if rdm <= cumulative:
			return ore
	
	return 0


static func roll_ore_quarry() -> int:
	var total = get_total_ore_quarry_weight()
	var rdm = randf() * total
	var cumulative = 0
	
	for ore in Data.ORE_QUARRY_WEIGHT:
		cumulative += Data.ORE_QUARRY_WEIGHT[ore]
		
		if rdm <= cumulative:
			return ore
	
	return 0


static func get_ore_quarry_icon(ore: Data.ORE_QUARRY) -> Texture2D:
	return Database.quarry_icons[ore % 110]
