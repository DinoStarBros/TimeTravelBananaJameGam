extends Node
class_name State

@onready var p : Player = owner

var state_machine : StateMachine
var frames : int = 0
var state_duration : float = 0

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass

func handle_input(input: InputEvent) -> void:
	pass
