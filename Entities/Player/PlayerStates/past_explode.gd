extends State

func enter() -> void:
	state_duration = 0.2
	p.hurtbox.disabled = true

func physics_update(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	
	if state_duration <= 0: 
		state_machine.change_state("Walkdle")

func exit() -> void:
	p.hurtbox.disabled = false
