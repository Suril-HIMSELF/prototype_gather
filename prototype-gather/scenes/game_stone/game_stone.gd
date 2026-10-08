extends Control

@onready var center_control: Control = $CenterControl
@onready var stone_quantity: Label = $Header/HBoxContainer/StoneQuantity


const stone_effect_scene = preload("res://scenes/effects/stone/stone_effect.tscn")

var input: int = -1
var quantity: int = 0
var inventory: int = 0

func _ready() -> void:
	InputManager.input_detected.connect(_on_input_detected)
	
	stone_quantity.text = str(GameManager.get_item_amount(Database.items["stone"]))


func _process(delta: float) -> void:
	if input != -1:
		match input:
			0:
				quantity = 1
			1:
				quantity = 5
			2,3,4,5:
				quantity = 3
		
		collect_stone(quantity)
	
	input = -1


func collect_stone(qty: int) -> void:
	play_stone()
	
	GameManager.add_item(Database.items["stone"], qty)
	
	update_inventory()


func update_inventory() -> void:
	stone_quantity.text = str(GameManager.get_item_amount(Database.items["stone"]))


func play_stone() -> void:
	var effect := stone_effect_scene.instantiate() as StoneEffect
	
	center_control.add_child(effect)
	effect.play()

func _on_input_detected(type: InputManager.InputType) -> void:
	input = type


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
