extends PanelContainer

@onready var _grid_container = $GridContainer
@onready var _texture_rect = $TextureRect

@export var _item: Item
@onready var slot: PackedScene

func set_item(item: Item):
	_item = item
	initialize()
	
func initialize():
	var item_columns = _item.size.x
	var item_rows = _item.size.y
	_grid_container.columns = item_columns
	for i in range(item_columns):
		for j in range(item_rows):
			var new_slot = slot.instantiate()
			new_slot.set_slot_position(i, j)
			_grid_container.add_child(new_slot)
			_texture_rect.texture = _item.icon


func _ready():
	slot = preload("res://inventory/slot/slot.tscn")
	initialize()
