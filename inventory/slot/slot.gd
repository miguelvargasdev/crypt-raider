class_name Slot
extends Control

var _x_position: int = 0
var _y_position: int = 0
var _item: Item
@onready var xy_label: Label
@onready var item_label: Label
@onready var item_texture: TextureRect

signal slot_clicked(slot: Slot)

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_clicked.emit(self)

# Called when the node enters the scene tree for the first time.
func _ready():
	xy_label = get_node("XYPosition")
	item_label = $ItemLabel
	item_texture =$ItemTexure
	xy_label.text = "(%s,%s)" % [_x_position, _y_position] 

func set_slot_position(x: int, y: int):
	_x_position = x
	_y_position = y

func set_item(item: Item):
	_item = item
	item_label.text = item.name
	item_texture.texture = item.icon as Texture2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
