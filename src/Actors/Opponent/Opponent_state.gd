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
onready var stopwatch = get_node("/root/LevelCity/Stopwatch/stopwatch")

func setup(change_state, opponent_sprite, persistent_state):
	self.change_state = change_state
	self.opponent_sprite = opponent_sprite
	self.persistent_state = persistent_state


func flip_sprite(velocity):
	if velocity.x < 0:
		opponent_sprite.set_flip_h(true)
	elif velocity.x > 0:
		opponent_sprite.set_flip_h(false)


func freeze_character(character, character_sprite) -> void:
		character.set_physics_process(false)
		character.set_process(false)
		character_sprite.set_process(false)
		character_sprite.stop()
		
		flash_sprite(character_sprite)
		yield(get_tree().create_timer(0.5), "timeout")
		
		character.set_physics_process(true)
		character.set_process(true)
		character_sprite.set_process(true)


func flash_sprite(character_sprite) -> void:
	character_sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color(1, 1, 1)
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color(1, 1, 1)
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color(1, 1, 1)
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	character_sprite.modulate = Color(1, 1, 1)


func stopwatch(delta) -> void:
	Global.stopwatch += delta;
	stopwatch.text = "%0.2f" % Global.stopwatch
	if Global.stopwatch > 0:
		stopwatch.add_color_override("font_color", Color("#6bb572"))
	else:
		stopwatch.add_color_override("font_color", Color("#c24c4c"))
