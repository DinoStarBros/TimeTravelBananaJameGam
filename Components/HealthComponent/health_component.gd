extends Node2D
class_name HealthComponent

@export var health_bar : ProgressBar
@export var corpse_spawner : CorpseSpawner
@export var max_hp : int = 1
var hp : int:
	set(value):
		hp = value

func _ready() -> void:
	hp = max_hp

func took_damage(attack : Attack) -> void:
	hp -= 1
	
	if hp <= 0:
		if get_parent() is Enemy:
			get_parent().queue_free()
			if corpse_spawner:
				corpse_spawner.dead(attack)

func _physics_process(delta: float) -> void:
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = hp
