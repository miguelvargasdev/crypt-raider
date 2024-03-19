extends MarginContainer

@export var slot: PackedScene
@onready var grid_container: GridContainer = $GridContainer
var _bag: Bag
var slots:Array 

@export var _bag_inventory: Array[Item]
@onready var _item_container

func set_bag(bag: Bag):
	_bag = bag
	_instantiate_grid()
	
func _instantiate_grid():
	if _bag == null: pass
	 
	var grid_columns = _bag.size.x
	var grid_rows = _bag.size.y
	
	grid_container.columns = grid_columns
	for i in range(grid_rows):
		var nested_arr = []
		for j in range(grid_columns):
			var new_slot = slot.instantiate()
			new_slot.set_slot_position(i,j)
			new_slot.connect("slot_clicked", _on_slot_clicked)
			grid_container.add_child(new_slot)
			nested_arr.push_back(new_slot) 
		slots.push_back(nested_arr)

func _on_slot_clicked(slot: Slot):
	print("Slot clicked: %s (%s,%s)" % [_bag.bag_name, slot._x_position, slot._y_position])
	print(slot.get_screen_position())
	slot.set_item(_bag_inventory[0])
	
	
	#var new_item = _item_container.instantiate()
	#new_item._item = _bag_inventory[0]
	#add_child(new_item)
	#new_item.position = slot.get_screen_position()
	

func _item_fits_in_bag(item: Item, bag: Bag):
	for itemX in range(item.size.x):
		for itemY in range(item.size.y):
			var bagX = bag.size.x + itemX
			var bagY = bag.size.y + itemY
			
	
func _ready():
	_item_container = preload("res://inventory/item/item_container.tscn")
	pass
