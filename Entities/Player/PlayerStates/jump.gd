extends State

func enter() -> void:
	p.reset_sprite_flip_gravity()
	p.velocity.y = -p.jump_speed

func update(delta: float) -> void:
	p.x_move_handling()
	
	if p.velocity.y > 0:
		state_machine.change_state("fall")
	
	if not Input.is_action_pressed("jump"):
		p.velocity.y = 0

	p.dash_handling()
