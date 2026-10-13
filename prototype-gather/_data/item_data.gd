class_name ItemData
extends Resource

enum ITEM_TYPE {
	WOOD,
	STONE,
	GEM,
}

@export var id: String
@export var icon: Texture2D
@export var type: ITEM_TYPE
