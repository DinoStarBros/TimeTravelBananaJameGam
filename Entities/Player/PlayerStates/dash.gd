extends State

func enter() -> void:
	p.velocity.x = p.dash_speed * p.last_x_input
	p.velocity.y = 0
	p.enable_gravity = false
	p.override_flip_sprite = true
	state_duration = p.dash_duration
	p.hurtbox.disabled = true
	%anims.play("dash")

func physics_update(delta: float) -> void:
	p.slash_attack_handling()
	
	state_duration = max(state_duration - delta, 0)
	p.velocity.y = 0
	if state_duration <= 0:
		state_machine.change_state("walkdle")
	
	p.velocity.x *= 0.9
	p.rewind_ult_handling()


func exit() -> void:
	p.time_since_dash = 0
	p.hurtbox.disabled = false
