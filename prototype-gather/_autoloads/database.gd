extends Node


# Game data
var items: Dictionary = {}
var recipes: Dictionary = {}
var mine_icons: Array[Texture2D]
var quarry_icons: Array[Texture2D]

func initialize() -> void:
	load_all_items()
	load_all_recipes()
	load_quarry_atlas()


func load_all_items():
	var path = "res://_data/item_data/"

	var dir = DirAccess.open(path)
	if dir == null:
		push_error("No data folder")
		return

	dir.list_dir_begin()

	var files = ResourceLoader.list_directory(path)

	for file in files:
		var item = load(path + file)

		items[item.id] = item

	dir.list_dir_end()


func load_all_recipes():
	var path = "res://_data/recipe_data/"

	var dir = DirAccess.open(path)
	if dir == null:
		push_error("No data folder")
		return

	dir.list_dir_begin()

	var files = ResourceLoader.list_directory(path)

	for file in files:
		var recipe = load(path + file)

		recipes[recipe.id] = recipe

	dir.list_dir_end()


func load_mine_atlas() -> void:
	mine_icons = []
	
	var atlas = load("res://assets/atlas/mine_atlas.png")
	
	for x in range(5):
		var icon = AtlasTexture.new()
		icon.atlas = atlas
		icon.region = Rect2(x * 128, 0, 128, 128)
		
		quarry_icons.append(icon)


func load_quarry_atlas() -> void:
	quarry_icons = []
	
	var atlas = load("res://assets/atlas/quarry_atlas.png")
	
	for x in range(5):
		var icon = AtlasTexture.new()
		icon.atlas = atlas
		icon.region = Rect2(x * 128, 0, 128, 128)
		
		quarry_icons.append(icon)


func get_item_by_type(type: ItemData.ITEM_TYPE) -> Array[ItemData]:
	var results: Array[ItemData] = []
	
	for item in Database.items.values():
		if item.type == type:
			results.append(item)
	
	return results


func get_recipes_by_type(type: RecipeData.RECIPE_TYPE) -> Array[RecipeData]:
	var results: Array[RecipeData] = []
	
	for recipe in Database.recipes.values():
		if recipe.type == type:
			results.append(recipe)
	
	return results
