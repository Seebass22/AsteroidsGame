extends Label

func _ready():
	GameEvents.connect("correct_asteroid", self, "_on_correct_asteroid_destroyed")
	GameEvents.connect("incorrect_asteroid", self, "_on_incorrect_asteroid_destroyed")
	set_text("")

func _on_correct_asteroid_destroyed(ignored):
	set_text("Correct!")
	$Timer.start()
	yield($Timer, "timeout")
	set_text("")

func _on_incorrect_asteroid_destroyed(ignored):
	set_text("Wrong!")
	$Timer.start()
	yield($Timer, "timeout")
	set_text("")
