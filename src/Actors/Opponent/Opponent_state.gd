extends Actor
class_name Opponent_state

# https://docs.godotengine.org/en/stable/tutorials/misc/state_design_pattern.html

var change_state
var persistent_state
var run_speed = 650.0
var freeze_length = 1.5
onready var player = get_node("/root/LevelCity/Player")
onready var player_sprite = player.get_node("AnimatedSprite")
onready var opponent = get_node("/root/LevelCity/Opponent")
onready var opponent_sprite = opponent.get_node("AnimatedSprite")
onready var camera = player.get_node("Camera2D")
onready var stopwatch = get_node("/root/LevelCity/Stopwatch")


func setup(change_state, opponent_sprite, persistent_state):
	self.change_state = change_state
	self.opponent_sprite = opponent_sprite
	self.persistent_state = persistent_state


func flip_sprite(velocity):
	if velocity.x < 0:
		opponent_sprite.set_flip_h(true)
	elif velocity.x > 0:
		opponent_sprite.set_flip_h(false)


func stall(character) -> void:
	character.freeze()
	camera.add_trauma(0.35)
	character.flash_sprite()
	yield(get_tree().create_timer(freeze_length), "timeout")
	character.unfreeze()


func freeze() -> void:
	Global._freeze(self, opponent_sprite)
func unfreeze() -> void:
	Global._unfreeze(self, opponent_sprite)
	opponent_sprite.play("llama")
func flash_sprite() -> void:
	Global._flash_sprite(opponent_sprite)
