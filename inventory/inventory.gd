extends PanelContainer

@onready var bag_container: PackedScene
@export var inventory: Array[Bag]


# Makes the inventory panel appear/disappear
func toggle_inventory():
	pass

func initialize():
	#print
	for bag in inventory:
		print("Creating new bag...")
		var new_bag_container = bag_container.instantiate()
		$VBoxContainer.add_child(new_bag_container)
		new_bag_container.set_bag(bag)
		print("Bag created.")

func _ready():
	bag_container = preload("res://inventory/bag/bag_container.tscn")
	initialize()
