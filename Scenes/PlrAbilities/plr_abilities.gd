extends Node2D
class_name PlrAbilities

@export var player : Player

var rew_des_pos : Vector2
var rang_des_pos : Vector2

func _process(delta: float) -> void:
	if player.chronometer >= 10:
		rew_des_pos.y = -20
	else:
		rew_des_pos.y = 0
	
	%rew.position.y = lerp(%rew.position.y, rew_des_pos.y, 12.0 * delta)

	if player.chronometer >= 2:
		rang_des_pos.y = -20
	else:
		rang_des_pos.y = 0
	
	%rang.position.y = lerp(%rang.position.y, rang_des_pos.y, 12.0 * delta)
