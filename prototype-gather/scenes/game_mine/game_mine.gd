extends Control

@onready var center_control: Control = $CenterControl
@onready var stone_quantity: Label = $Header/HBoxContainer/StoneContainer/StoneQuantity
@onready var iron_quantity: Label = $Header/HBoxContainer/IronContainer/IronQuantity
@onready var gold_quantity: Label = $Header/HBoxContainer/GoldContainer/GoldQuantity
@onready var sapphire_quantity: Label = $Header/HBoxContainer/SapphireContainer/SappphireQuantity
@onready var ruby_quantity: Label = $Header/HBoxContainer/RubyContainer/RubyQuantity


const wood_effect_scene = preload("res://scenes/effects/wood/wood_effect.tscn")

var input: int = -1
var quantity: int = 0
var inventory: int = 0

func _ready() -> void:
	InputManager.input_detected.connect(_on_input_detected)
	
	stone_quantity.text = str(GameManager.get_item_amount(Database.items["stone"]))
	iron_quantity.text = str(GameManager.get_item_amount(Database.items["iron"]))
	gold_quantity.text = str(GameManager.get_item_amount(Database.items["gold"]))
	sapphire_quantity.text = str(GameManager.get_item_amount(Database.items["sapphire"]))
	ruby_quantity.text = str(GameManager.get_item_amount(Database.items["ruby"]))


func _process(delta: float) -> void:
	if input != -1:
		match input:
			0:
				quantity = 1
			1:
				quantity = 5
			2,3,4,5:
				quantity = 3
		
		var ore = Utils.roll_ore()
		collect_ore(ore, quantity)
	
	input = -1


func collect_ore(ore: Data.ORE, qty: int) -> void:
	play_wood()
	
	GameManager.add_item(Database.items[Data.ORE_ID[ore]], qty)
	
	update_inventory()


func update_inventory() -> void:
	stone_quantity.text = str(GameManager.get_item_amount(Database.items["stone"]))
	iron_quantity.text = str(GameManager.get_item_amount(Database.items["iron"]))
	gold_quantity.text = str(GameManager.get_item_amount(Database.items["gold"]))
	sapphire_quantity.text = str(GameManager.get_item_amount(Database.items["sapphire"]))
	ruby_quantity.text = str(GameManager.get_item_amount(Database.items["ruby"]))


func play_wood() -> void:
	var effect := wood_effect_scene.instantiate() as WoodEffect
	
	center_control.add_child(effect)
	effect.play()

func _on_input_detected(type: InputManager.InputType) -> void:
	input = type


func _on_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
