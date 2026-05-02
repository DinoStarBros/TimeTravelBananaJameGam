extends State

func enter() -> void:
	p.reset_sprite_flip_gravity()
	p.velocity.y = -p.jump_speed

	%jump.pitch_scale = 1.2 + randf_range(-.1, .1)
	%jump.play()

func physics_update(delta: float) -> void:
	p.x_move_handling()
	
	if p.velocity.y > 0:
		state_machine.change_state("fall")
	
	if not Input.is_action_pressed("jump"):
		p.velocity.y = 0

	p.dash_handling()
	p.slash_attack_handling()
	p.boomerang_handle(delta)
