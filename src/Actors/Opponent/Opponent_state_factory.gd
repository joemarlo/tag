class_name Opponent_state_factory

var states

func _init():
	states = {
		"chase": Opponent_state_chase,
		"evade": Opponent_state_evade
}

func get_state(state_name):
	if states.has(state_name):
		return states.get(state_name)
	else:
		printerr("No state ", state_name, " in state factory!")
