extends State

#p.get_dir_to_plr()
#p.get_dist_to_plr()

func enter() -> void:
	state_duration = p.attack_windup_time

func physics_update(delta: float) -> void:
	p.velocity.x *= 0.8
	state_duration = max(0, state_duration-delta)
	if state_duration <= 0:
		state_machine.change_state("Shoot")
