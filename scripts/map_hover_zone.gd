@tool
extends Node2D

@export var outline_image: Texture2D
@export var hover_image: Texture2D
@export var country: Country

@onready var outline_img_node = $OutlineImg
@onready var hover_img_node = $HoverImg
@onready var hover_sound_node = $HoverSound
@onready var click_sound_node = $ClickSound
	

func _ready() -> void:
	
	outline_img_node.texture = outline_image
	hover_img_node.texture = hover_image
	
	if not Engine.is_editor_hint():
		outline_img_node.visible = false
		hover_img_node.visible = false

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		outline_img_node.texture = outline_image
		hover_img_node.texture = hover_image

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_viewport().set_input_as_handled()
		click_sound_node.play()

func _on_mouse_entered() -> void:
	hover_sound_node.play()
	hover_img_node.visible = true

func _on_mouse_exited() -> void:
	hover_img_node.visible = false
