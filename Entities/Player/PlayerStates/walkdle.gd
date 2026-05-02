extends State

func enter() -> void:
	p.reset_sprite_flip_gravity()

func physics_update(delta: float) -> void:
	p.x_move_handling()
	
	if p.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			state_machine.change_state("Jump")
		if Input.is_action_pressed("down"):
			p.global_position.y += 1
	
	if p.velocity.y > 0:
		state_machine.change_state("fall")
	
	p.dash_handling()
	p.slash_attack_handling()
	p.boomerang_handle(delta)
	p.rewind_ult_handling()
