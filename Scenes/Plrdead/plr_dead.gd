extends Control

const strings : Array[String] = [
	"I should try something else next time...",
	"Well, that won't work...",
	"I have to remember to avoid that...",
	"Well, that's just unfair...",
	"I should learn how to avoid that...",
	
]

func _ready() -> void:
	%text.text = str(
		strings.pick_random()
	)
