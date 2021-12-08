extends Node2D

onready var player = get_node("/root/LevelCity/Player")
onready var player_sprite = player.get_node("AnimatedSprite")
onready var opponent = get_node("/root/LevelCity/Opponent")
onready var opponent_sprite = opponent.get_node("AnimatedSprite")
var stopwatch_range = Global.stopwatch_range


func _process(delta):
	end_game()


func end_game() -> void:
	if Global.stopwatch <= stopwatch_range[0]:
		lose_game()
	elif Global.stopwatch >= stopwatch_range[1]:
		win_game()


func win_game() -> void:
	freeze_game()
	# TODO: shake stopwatch or something
	restart_game()


func lose_game() -> void:
	freeze_game()
	restart_game()


func freeze_game() -> void:
	player.freeze()
	opponent.freeze()


func restart_game() -> void:
	# pause before showing menu
	yield(get_tree().create_timer(1.5), "timeout")

	# unfreeze characters
	player.unfreeze()
	opponent.unfreeze()
	
	Global._reset_game()
