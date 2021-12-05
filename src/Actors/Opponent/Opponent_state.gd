extends Actor
class_name Opponent_state

# https://docs.godotengine.org/en/stable/tutorials/misc/state_design_pattern.html

var change_state
var persistent_state
var run_speed = 800.0
onready var player = get_node("/root/LevelCity/Player")
onready var player_sprite = player.get_node("AnimatedSprite")
onready var opponent = get_node("/root/LevelCity/Opponent")
onready var opponent_sprite = opponent.get_node("AnimatedSprite")

func setup(change_state, opponent_sprite, persistent_state):
	self.change_state = change_state
	self.opponent_sprite = opponent_sprite
	self.persistent_state = persistent_state

func flip_sprite(velocity):
	if velocity.x < 0:
		opponent_sprite.set_flip_h(true)
	elif velocity.x > 0:
		opponent_sprite.set_flip_h(false)
