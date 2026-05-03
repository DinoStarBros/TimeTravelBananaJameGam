extends State

func enter() -> void:
	p.reset_sprite_flip_gravity()
	p.jump_buffer_time = 0
	
	%anims.play("fall")

func physics_update(delta: float) -> void:
	p.x_move_handling()
	if p.is_on_floor():
		state_machine.change_state("walkdle")
	
	if Input.is_action_pressed("jump"):
		p.jump_buffer_time += delta
	else:
		p.jump_buffer_time = 0
	
	if (p.jump_buffer_time <= 0.2 and
		Input.is_action_pressed("jump") and
		p.is_on_floor()
		):
		state_machine.change_state("jump")
	
	p.dash_handling()
	p.slash_attack_handling()
	p.boomerang_handle(delta)
	p.rewind_ult_handling()
