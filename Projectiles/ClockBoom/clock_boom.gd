extends Node2D
class_name ClockBoom

var enabled : bool = false
var desire_scale : float = 0

func _ready() -> void:
	%Timer.timeout.connect(_spawn_click_boom)

func _process(delta: float) -> void:
	if enabled:
		desire_scale = 4
	else:
		desire_scale = 0
	
	scale.x = lerp(scale.x, desire_scale, 8.0 * delta)
	scale.y = scale.x

func enable() -> void: enabled = true

func disable() -> void: enabled = false

func _spawn_click_boom() -> void:
	var click_boom : ClickBoom = References.click_boom_scn.instantiate()
	Global.arena.add_child(click_boom)
	click_boom.global_position = global_position
	click_boom.scale = Vector2(5,5)
	click_boom.modulate = Color.ORANGE_RED
