extends HBoxContainer

var recipe: RecipeData


func setup(_recipe: RecipeData) -> void:
	var ingredients: HBoxContainer = $Ingredients
	var output_icon: TextureRect = $Output/OutputIcon
	var output_quantity: Label = $Output/OutputQuantity
	
	recipe = _recipe
	
	for ingredient in _recipe.ingredients:
		var item_button = Button.new()
		
		item_button.custom_minimum_size = Vector2(100, 100)
		
		var item_icon = TextureRect.new()
		
		item_icon.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		item_icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		item_icon.set_anchors_preset(Control.PRESET_FULL_RECT)
		item_icon.texture = ingredient.item.icon
		
		item_button.add_child(item_icon)
		
		var item_quantity = Label.new()
		
		item_button.add_child(item_quantity)
		item_quantity.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		item_quantity.text = str(ingredient.amount)

		item_quantity.set_anchors_preset(Control.PRESET_BOTTOM_RIGHT)
		item_quantity.grow_horizontal = Control.GROW_DIRECTION_BEGIN
		item_quantity.grow_vertical = Control.GROW_DIRECTION_BEGIN
		item_quantity.position -= Vector2(8, 8)
		
		
		ingredients.add_child(item_button)
	
	output_icon.texture = _recipe.output.icon
	output_quantity.text = str(_recipe.output_amount)


func _on_output_pressed() -> void:
	GameManager.craft(recipe)
