extends State

func enter() -> void:
	p.enable_gravity = false
	state_duration = p.slash_duration
	p.velocity = p.dir_to_mouse * p.slash_speed
	p.hurtbox.disabled = true

func physics_update(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		state_machine.change_state("walkdle")
	
	#if p.is_on_floor():
	p.global_position.y += 1
	
	
	p.velocity *= 0.8
	p.rewind_ult_handling()

func exit() -> void:
	p.time_since_slash = 0
	p.velocity.y = 0
	p.hurtbox.disabled = false
