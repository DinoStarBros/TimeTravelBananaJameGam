extends State

func enter() -> void:
	Global.current_game_state = Global.game_states.DEAD
	get_tree().paused = true
	%hurt.play()
	%hurt2.play(1.9)
	p.velocity = Vector2.ZERO
