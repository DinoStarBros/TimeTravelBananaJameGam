extends State

#p.get_dir_to_plr()
#p.get_dist_to_plr()

func enter() -> void:
	state_duration = p.attack_duration
	p.velocity = p.get_dir_to_plr() * p.attack_velocity
	%DashSFX.pitch_scale += randf_range(-.2, .2)
	%DashSFX.play()

func physics_update(delta: float) -> void:
	state_duration = max(0, state_duration-delta)
	if state_duration <= 0:
		state_machine.change_state("Chase")
