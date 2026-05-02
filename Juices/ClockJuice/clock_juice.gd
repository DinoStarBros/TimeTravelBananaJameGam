extends Node2D
class_name ClockJuice

var enabled : bool = false
var desire_scale : float = 0

func _process(delta: float) -> void:
	if enabled:
		desire_scale = 2
	else:
		desire_scale = 0
	
	scale.x = lerp(scale.x, desire_scale, 8.0 * delta)
	scale.y = scale.x
