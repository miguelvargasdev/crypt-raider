extends MarginContainer

# FILEPATH: /home/moogle/Documents/Projects/crypt-raider/inventory/bag/bag_container.gd

# The scene to be used as a template for each slot in the bag container.
@export var _slot: PackedScene

# The GridContainer node that will hold the slots in the bag container.
@onready var grid_container: GridContainer = $GridContainer

# The Bag instance associated with this bag container.
var _bag: Bag

# An array to store references to the slots in the bag container.
var slots: Array

# The inventory of items in the bag.
@export var _bag_inventory: Array[Item]

# The container node that will hold the item instances in the bag container.
@onready var _item_container

# Sets the bag for the bag container.
# This function assigns the provided `bag` to the `_bag` variable and calls `_instantiate_grid()` to instantiate the grid for the bag.
func set_bag(bag: Bag):
	_bag = bag
	_instantiate_grid()

# Instantiates the grid based on the bag size.
func _instantiate_grid():
	if _bag == null: return

	grid_container.columns = _bag.size.x
	_generate_grid(_bag.size.x, _bag.size.y)
		
# Generates a grid of slots in the bag container.
# Each slot is instantiated, positioned, and connected to the slot_clicked signal.
# The slots are added as children to the grid_container node.
# The slots are stored in a 2D array for easy access.
func _generate_grid(col: int, row: int):
	for i in range(row):
		var nested_arr = []
		for j in range(col):
			var new_slot = _slot.instantiate()
			new_slot.set_slot_position(j,i)
			new_slot.connect("slot_clicked", _on_slot_clicked)
			grid_container.add_child(new_slot)
			nested_arr.push_back(new_slot) 
		slots.push_back(nested_arr)

# Called when a slot is clicked in the bag container.
# Checks if the item can fit in the bag from the clicked slot.
func _on_slot_clicked(slot: Slot):
	print_rich("Slot clicked: [color=green]%s (%s,%s)" % [_bag.bag_name, slot.pos.x, slot.pos.y])
	_can_item_fit_in_bag_from_slot(_bag_inventory[0], _bag, slot)

# Checks if an item can fit in a bag from a specific slot.
# Returns true if the item can fit, false otherwise.
func _can_item_fit_in_bag_from_slot(item: Item, bag: Bag, slot: Slot) -> bool:
	var slot_pos = Vector2(slot._x_position, slot._y_position)
	
	if bag.size.x - slot_pos.x >= item.size.x && bag.size.y - slot_pos.y >= item.size.y:
		if _are_slots_occupied(item, bag, slot):
			print("%s can fit here." % item.name)
			return true
		else:
			print("Space occupied or out of bounds.")
			return false
	
	print("%s cannot fit here." % item.name)
	return false

# Checks if the slots specified by the given item, bag, and slot are occupied.
# Returns true if all the slots are unoccupied, otherwise returns false.
func _are_slots_occupied(item: Item, bag: Bag, slot: Slot) -> bool:
	var slot_pos = Vector2(slot.pos.x,slot.pos.y)
	for i in range(slot_pos.x, slot_pos.x + item.size.x):
		for j in range(slot_pos.y, slot_pos.y + item.size.y):
			if i >= slots.size() or j >= slots[i].size():
				return false
			if slots[i][j]._occupied:
				return false
	return true

func _ready():
	_item_container = preload("res://inventory/item/item_container.tscn")
	pass
