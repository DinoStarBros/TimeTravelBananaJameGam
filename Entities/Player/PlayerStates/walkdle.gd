extends State

func enter() -> void:
	p.reset_sprite_flip_gravity()

func update(delta: float) -> void:
	p.x_move_handling()
	
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("Jump")
	
	if p.velocity.y > 0:
		state_machine.change_state("fall")
	
	p.dash_handling()
