extends Node2D

@onready var camera: Camera = %Camera

var cam_desire_pos : Vector2
var screen_half : Vector2

func _ready() -> void:
	screen_half = get_viewport_rect().size / 2

func _process(delta: float) -> void:
	
	cam_desire_pos = (Global.player.global_position + screen_half + Vector2(0, -300)) / 2
	camera.global_position.x = lerp(camera.global_position.x, cam_desire_pos.x, 15.0 * delta)
