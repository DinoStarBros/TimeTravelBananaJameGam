extends State

#p.get_dir_to_plr()
#p.get_dist_to_plr()

func enter() -> void:
	pass

func physics_update(delta: float) -> void:
	p.velocity.x = p.get_dir_to_plr().x * p.x_speed
	
	if p.get_dist_to_plr() <= p.attack_range:
		state_machine.change_state("ShootWind")
	
	if p.get_dir_to_plr().y < -0.5 and p.is_on_floor():
		p.velocity.y = -p.jump_speed
	
	p.platforming_basic()
