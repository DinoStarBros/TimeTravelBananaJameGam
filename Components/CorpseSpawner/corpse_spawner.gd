extends Node2D
class_name CorpseSpawner

#@export var corpse_texture : Texture2D
@export var corpse_color : Color

var dir_to_atk : Vector2

const flying_corpse_scn : PackedScene = preload("res://Juices/FlyingCorpse/flying_corpse.tscn")

func dead(attack: Attack) -> void:
	dir_to_atk = -global_position.direction_to(get_global_mouse_position())
	_spawn_flying_corpse()

func _spawn_flying_corpse() -> void:
	var flying_corpse : FlyingCorpse = flying_corpse_scn.instantiate()
	#flying_corpse.sprite_texture = corpse_texture
	flying_corpse.dir_to_attack = dir_to_atk
	flying_corpse.global_position = global_position
	Global.arena.add_child(flying_corpse)
	flying_corpse.modulate = corpse_color
