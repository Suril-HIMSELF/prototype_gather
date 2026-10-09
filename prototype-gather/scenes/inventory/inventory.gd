class_name Inventory extends Node


@onready var inventory_slots: GridContainer = $InventorySlots

const INVENTORY_SIZE: int = 20
const INVENTORY_SLOT_SCENE = preload("res://scenes/inventory/inventory_slot/inventory_slot.tscn")

func _ready() -> void:
	var __ = GameManager.item_crafted.connect(_on_item_crafted)
	
	_create_inventory_slots()
	_refresh_inventory()

func _create_inventory_slots():
	# CLEANUP SI REBUILD
	for child in inventory_slots.get_children():
		child.queue_free()

	# CREATE
	for i in range(INVENTORY_SIZE):
		var slot: InventorySlot = INVENTORY_SLOT_SCENE.instantiate()

		slot.inventory_index = i

		inventory_slots.add_child(slot)


func _refresh_inventory() -> void:
	var items = GameManager.inventory.keys()

	for i in inventory_slots.get_child_count():
		var inventory_slot = inventory_slots.get_child(i)

		if i < items.size():
			var item_id = items[i]
			inventory_slot.setup(item_id, GameManager.inventory[item_id])
		else:
			inventory_slot.clear()


func _on_item_crafted() -> void:
	_create_inventory_slots()
	
	await get_tree().process_frame
	
	_refresh_inventory()
