extends Control

@onready var center_control: Control = $CenterControl
@onready var wood_quantity: Label = $Header/HBoxContainer/WoodQuantity


const wood_effect_scene = preload("res://scenes/effects/wood/wood_effect.tscn")

var input: int = -1
var quantity: int = 0
var inventory: int = 0

func _ready() -> void:
	InputManager.input_detected.connect(_on_input_detected)
	
	wood_quantity.text = str(GameManager.get_item_amount(Database.items["wood"]))


func _process(delta: float) -> void:
	if input != -1:
		match input:
			0:
				quantity = 1
			1:
				quantity = 5
			2,3,4,5:
				quantity = 3
		
		collect_wood(quantity)
	
	input = -1


func collect_wood(qty: int) -> void:
	play_wood()
	
	GameManager.add_item(Database.items["wood"], qty)
	
	update_inventory()


func update_inventory() -> void:
	wood_quantity.text = str(GameManager.get_item_amount(Database.items["wood"]))


func play_wood() -> void:
	var effect := wood_effect_scene.instantiate() as WoodEffect
	
	center_control.add_child(effect)
	effect.play()

func _on_input_detected(type: InputManager.InputType) -> void:
	input = type


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
