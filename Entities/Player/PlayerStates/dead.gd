extends State

func enter() -> void:
	get_tree().paused = true
	%hurt.play()
	%hurt2.play(1.9)
	p.velocity = Vector2.ZERO
