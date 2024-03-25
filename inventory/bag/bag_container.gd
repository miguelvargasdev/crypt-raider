class_name BagContainer
extends MarginContainer

var _bag: Bag
var slots: Array

@export var _slot: PackedScene
@export var _bag_inventory: Array[Item]

@export var grid_container: GridContainer
@export var bag_name: TabBar

func set_bag(bag: Bag):
	_bag = bag
	_instantiate_grid()

func _instantiate_grid():
	if _bag == null: return

	grid_container.columns = _bag.size.x
	_generate_grid(_bag.size.x, _bag.size.y)
	bag_name.set_tab_title(0, _bag.bag_name)

		
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
	if slot._occupied:
		_remove_item(slot._item, slot.pos.x, slot.pos.y, slot.pos.x + slot._item.size.x, slot.pos.y + slot._item.size.y)
	else:
		_can_item_fit_in_bag_from_slot(_bag_inventory[0], _bag, slot)

func _can_item_fit_in_bag_from_slot(item: Item, bag: Bag, slot: Slot) -> bool:
	var slot_pos = Vector2(slot.pos.x, slot.pos.y)
	var end_x = slot_pos.x + item.size.x
	var end_y = slot_pos.y + item.size.y

	if end_x > bag.size.x or end_y > bag.size.y:
		print("%s is out of bounds." % item.name)
		return false

	for i in range(slot_pos.y, end_y):
		for j in range(slot_pos.x, end_x):
			if slots[i][j]._occupied:
				print("%s cannot fit here. Space occupied." % item.name)
				return false

	print("%s can fit here." % item.name)
	_place_item(item, slot_pos.x, slot_pos.y, end_x, end_y)
	return true

func _place_item(item: Item, start_x: int, start_y: int, end_x: int, end_y: int):
	for i in range(start_y, end_y):
		for j in range(start_x, end_x):
			slots[i][j].set_item(item)
	slots[start_y][start_x].resize_item_container(item)
	slots[start_y][start_x].visible_item_container(true)

func _remove_item(item: Item, start_x: int, start_y: int, end_x: int, end_y: int):
	for i in range(start_y, end_y):
		for j in range(start_x, end_x):
			slots[i][j].remove_item()
	slots[start_y][start_x].visible_item_container(false)

func _ready():
	pass
