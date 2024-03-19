class_name Slot
extends Control

var _occupied = false
var pos: Vector2i = Vector2i(0,0)
var _item: Item
@onready var xy_label: Label
@onready var item_label: Label
@onready var item_texture: TextureRect
@onready var item_container: PanelContainer

signal slot_clicked(slot: Slot)

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		slot_clicked.emit(self)

func _ready():
	xy_label = get_node("XYPosition")
	item_label = $ItemLabel
	item_texture =$ItemContainer/ItemIcon
	item_container = $ItemContainer
	xy_label.text = "(%s,%s)" % [pos.x, pos.y]

func set_slot_position(x: int, y: int):
	pos.x = x
	pos.y = y

func set_item(item: Item):
	_item = item
	item_label.text = item.name
	item_texture.texture = item.icon as Texture2D
	_occupied = true

func set_item_container(item: Item):
	item_container.set_size(item.size * 32)
	item_container.show()