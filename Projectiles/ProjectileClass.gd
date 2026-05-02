extends Node2D
class_name Projectile

var velocity : Vector2

func _move(delta: float) -> void:
	global_position += velocity * delta
