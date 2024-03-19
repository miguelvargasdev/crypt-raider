class_name BagContainer
extends MarginContainer

var _bag: Bag
var slots: Array

@export var _slot: PackedScene
@export var _bag_inventory: Array[Item]

@onready var _item_container
@onready var grid_container: GridContainer = $GridContainer

func set_bag(bag: Bag):
	_bag = bag
	_instantiate_grid()

func _instantiate_grid():
	if _bag == null: return

	grid_container.columns = _bag.size.x
	_generate_grid(_bag.size.x, _bag.size.y)
		
func _generate_grid(col: int, row: int):
	if _slot == null:
		printerr("Error: _slot is null. Please assign a PackedScene to it.")
		return
	for i in range(row):
		var nested_arr = []
		for j in range(col):
			var new_slot = _slot.instantiate()
			new_slot.set_slot_position(j,i)
			new_slot.connect("slot_clicked", _on_slot_clicked)
			grid_container.add_child(new_slot)
			nested_arr.push_back(new_slot) 
		slots.push_back(nested_arr)

func _on_slot_clicked(slot: Slot):
	print_rich("Slot clicked: [color=green]%s (%s,%s)" % [_bag.bag_name, slot.pos.x, slot.pos.y])
	_can_item_fit_in_bag_from_slot(_bag_inventory[0], _bag, slot)

func _can_item_fit_in_bag_from_slot(item: Item, bag: Bag, slot: Slot) -> bool:
	var slot_pos = Vector2(slot.pos.x, slot.pos.y)
	
	if bag.size.x - slot_pos.x >= item.size.x && bag.size.y - slot_pos.y >= item.size.y:
		if _are_slots_occupied(item, slot):
			print("%s can fit here." % item.name)
			return true
		else:
			print("Space occupied or out of bounds.")
			return false
	
	print("%s cannot fit here." % item.name)
	return false

func _are_slots_occupied(item: Item, slot: Slot) -> bool:
	var slot_pos = Vector2(slot.pos.x, slot.pos.y)
	var end_x = slot_pos.x + item.size.x
	var end_y = slot_pos.y + item.size.y

	if end_x > slots.size() or end_y > slots[slot_pos.x].size():
		return false

	for i in range(slot_pos.y, end_y):
		for j in range(slot_pos.x, end_x):
			print("Position: %s, Occupied? %s, (i,j): (%s,%s)" % [slots[i][j].pos, slots[i][j]._occupied,i, j])
			if slots[i][j]._occupied:
				return false

	_place_item(item, slot_pos.x, slot_pos.y, end_x, end_y)
	return true

func _place_item(item: Item, start_x: int, start_y: int, end_x: int, end_y: int):
	for i in range(start_y, end_y):
		for j in range(start_x, end_x):
			slots[i][j].set_item(item)

	slots[start_y][start_x].set_item_container(item)
	

func _ready():
	_item_container = preload("res://inventory/item/item_container.tscn")
	pass
