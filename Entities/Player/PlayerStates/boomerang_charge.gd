extends State

func enter() -> void:
	%rang_charge.play()
	p.clock_juice.enabled = true
	p.chronometer -= p.banana_throw_chrono_req

func physics_update(delta: float) -> void:
	p.x_move_handling()
	if Input.is_action_just_pressed("jump") and p.is_on_floor():
		p.velocity.y = -p.jump_speed
	
	Engine.time_scale = p.rang_charge_time_slow
	
	if not Input.is_action_pressed("right_click"):
		if p.rang_charge >= p.max_rang_charge:
			state_machine.change_state("boomerangthrow")
		else:
			state_machine.change_state("walkdle")
		
	if Input.is_action_pressed("down") and p.is_on_floor():
		p.global_position.y += 1
	
	p.rang_charge += delta

func exit() -> void:
	Engine.time_scale = 1
	%rang_charge.stop()
	p.rang_charge = 0
	p.clock_juice.enabled = false
