extends Control

@onready var center_control: Control = $CenterControl
@onready var stone_quantity: Label = $Header/HBoxContainer/StoneQuantity


const stone_effect_scene = preload("res://scenes/effects/stone/stone_effect.tscn")

var input: int = -1
var quantity: int = 0
var inventory: int = 0

func _ready() -> void:
	InputManager.input_detected.connect(_on_input_detected)
	
	stone_quantity.text = str(GameManager.inventory[Enums.RESOURCE.STONE])


func _process(delta: float) -> void:
	if input != -1:
		if input != 1:
			quantity = 1
			print("+1 stone")
		else:
			quantity = 5
			print("+5 stone")
		
		collect_stone(quantity)
	
	input = -1


func collect_stone(qty: int) -> void:
	play_stone()
	
	GameManager.inventory[Enums.RESOURCE.STONE] += qty
	
	update_inventory()


func update_inventory() -> void:
	stone_quantity.text = str(GameManager.inventory[Enums.RESOURCE.STONE])


func play_stone() -> void:
	var effect := stone_effect_scene.instantiate() as StoneEffect
	
	center_control.add_child(effect)
	effect.play()

func _on_input_detected(type: InputManager.InputType) -> void:
	input = type


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
