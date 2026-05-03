extends CharacterBody2D
class_name Enemy

@export var x_speed : float = 400
@export var attack_range : float = 150
@export var attack_windup_time : float = 0.5
@export var attack_duration : float = 0.4
@export var attack_velocity : float = 500
@export var jump_speed : float = 600
@export var sprite : Sprite2D

func get_dir_to_plr() -> Vector2:
	var dir_to_plr : Vector2 = global_position.direction_to(Global.player.global_position)
	sprite.flip_h = dir_to_plr.x < 0
	
	return dir_to_plr

func get_dist_to_plr() -> float:
	return global_position.distance_to(Global.player.global_position)

func platforming_basic() -> void:
	if get_dir_to_plr().y < -0.5 and is_on_floor():
		velocity.y = -jump_speed
	
	if is_on_wall():
		velocity.y = -jump_speed
	
	if is_on_floor():
		global_position.y += 1
