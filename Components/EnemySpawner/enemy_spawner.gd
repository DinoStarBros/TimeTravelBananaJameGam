extends Node2D
class_name EnemySpawner

func spawn_enemy() -> void:
	var enemy : Enemy = References.enemy_scns.pick_random().instantiate()
	enemy.global_position = global_position
	Global.arena.add_child(enemy)
	pass
