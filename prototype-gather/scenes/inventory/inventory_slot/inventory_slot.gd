class_name InventorySlot extends Button

@onready var slot_icon: TextureRect = $SlotIcon
@onready var slot_quantity: Label = $SlotQuantity

var inventory_index: int = -1

func setup(item: ItemData, amount: int) -> void:
	slot_icon.texture = item.icon
	slot_quantity.text = str(amount)


func clear() -> void:
	slot_icon.texture = null
	slot_quantity.text = ""
