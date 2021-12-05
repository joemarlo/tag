extends Actor
class_name Opponent_state

# https://docs.godotengine.org/en/stable/tutorials/misc/state_design_pattern.html

var change_state
var animated_sprite
var persistent_state
var run_speed = 800.0
onready var player = get_node("../Player")

func setup(change_state, animated_sprite, persistent_state):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.persistent_state = persistent_state

