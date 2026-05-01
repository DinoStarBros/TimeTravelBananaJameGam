extends Area2D
class_name HurtboxComponent

@export var health_component : HealthComponent

func on_hit(attack: Attack) -> void:
	health_component.hp -= roundi(attack.damage)
