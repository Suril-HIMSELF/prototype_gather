extends Node


# Game data
var items: Dictionary = {}
var recipes: Dictionary = {}

func initialize() -> void:
	load_all_items()
	load_all_recipes()


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


func get_recipes_by_type(type: RecipeData.RECIPE_TYPE) -> Array[RecipeData]:
	var results: Array[RecipeData] = []
	
	for recipe in Database.recipes.values():
		if recipe.type == type:
			results.append(recipe)
	
	return results
