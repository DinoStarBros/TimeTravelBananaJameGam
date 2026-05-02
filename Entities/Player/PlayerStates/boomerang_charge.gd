extends State

func enter() -> void:
	%rang_charge.play()

func update(delta: float) -> void:
	p.x_move_handling()
	
	Engine.time_scale = p.rang_charge_time_slow
	
	if not Input.is_action_pressed("right_click"):
		state_machine.change_state("walkdle")
	
	p.rang_charge += delta

func exit() -> void:
	Engine.time_scale = 1
	%rang_charge.stop()
	p.rang_charge = 0
