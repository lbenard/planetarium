extends Node

var viewport_original_size = Vector2()
onready var viewport = $Viewport
onready var viewport_sprite = $ViewportSprite

func _ready():
	viewport_original_size = viewport.size

func _on_Viewport_size_changed():
	viewport.size = Vector2.ONE * get_viewport().size.y
	viewport_sprite.scale = Vector2(1, -1) * viewport_original_size.y / get_viewport().size.y
