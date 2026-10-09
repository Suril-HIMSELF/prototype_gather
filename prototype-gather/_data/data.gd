class_name Data extends Node


enum ORE {
	STONE,
	IRON,
	GOLD,
	SAPPHIRE,
	RUBY,
	EMERALD,
	DIAMOND
}

const ORE_ID: Dictionary = {
	ORE.STONE: "stone",
	ORE.IRON: "iron",
	ORE.GOLD: "gold",
	ORE.SAPPHIRE: "sapphire",
	ORE.RUBY: "ruby",
	ORE.EMERALD: "emerald",
	ORE.DIAMOND: "diamond",
}

const ORE_WEIGHT: Dictionary = {
	ORE.STONE: 0.7,
	ORE.IRON: 0.3,
	ORE.GOLD: 0.2,
	ORE.SAPPHIRE: 0.1,
	ORE.RUBY: 0.06,
	ORE.EMERALD: 0.03,
	ORE.DIAMOND: 0.01,
}
