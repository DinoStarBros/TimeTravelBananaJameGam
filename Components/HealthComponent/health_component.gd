extends Node2D
class_name HealthComponent

@export var health_bar : ProgressBar

@export var max_hp : int = 10000
var hp : int:
	set(value):
		hp = value

func _ready() -> void:
	hp = max_hp

func _physics_process(delta: float) -> void:
	if health_bar:
		health_bar.max_value = max_hp
		health_bar.value = hp
