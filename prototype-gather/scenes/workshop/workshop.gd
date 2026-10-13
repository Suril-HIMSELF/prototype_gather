extends Control

@onready var background: TextureRect = $Background
@onready var recipes_container: VBoxContainer = $VBoxContainer/RecipesContainer/ScrollContainer/RecipesContainer

const RECIPE_SCENE = preload("res://scenes/recipe/recipe.tscn")
const BACKGROUND_FORGE = preload("res://assets/backgrounds/background_forge.png")
const BACKGROUND_SAWMILL = preload("res://assets/backgrounds/background_sawmill.png")
const BACKGROUND_JEWELRY = preload("res://assets/backgrounds/background_jewelry.png")


func _ready() -> void:
	display_background(RecipeData.RECIPE_TYPE.FORGE)
	display_recipes(RecipeData.RECIPE_TYPE.FORGE)


func display_background(type: RecipeData.RECIPE_TYPE) -> void:
	match type:
		RecipeData.RECIPE_TYPE.FORGE: background.texture = BACKGROUND_FORGE
		RecipeData.RECIPE_TYPE.SAWMILL: background.texture = BACKGROUND_SAWMILL
		RecipeData.RECIPE_TYPE.JEWELRY: background.texture = BACKGROUND_JEWELRY


func display_recipes(type: RecipeData.RECIPE_TYPE) -> void:
	clear_recipes()
	
	for data in Database.get_recipes_by_type(type):
		var recipe = RECIPE_SCENE.instantiate()
		
		recipe.setup(data)
		
		recipes_container.add_child(recipe)


func clear_recipes() -> void:
	for node in recipes_container.get_children():
		node.queue_free()


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _on_forge_pressed() -> void:
	display_background(RecipeData.RECIPE_TYPE.FORGE)
	display_recipes(RecipeData.RECIPE_TYPE.FORGE)


func _on_sawmill_pressed() -> void:
	display_background(RecipeData.RECIPE_TYPE.SAWMILL)
	display_recipes(RecipeData.RECIPE_TYPE.SAWMILL)


func _on_jewelry_pressed() -> void:
	display_background(RecipeData.RECIPE_TYPE.JEWELRY)
	display_recipes(RecipeData.RECIPE_TYPE.JEWELRY)
