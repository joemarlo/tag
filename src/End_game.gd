extends Node2D

onready var player = get_node("/root/LevelCity/Player")
onready var player_sprite = player.get_node("AnimatedSprite")
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
	# freeze player sprite
	player.set_physics_process(false)
	player_sprite.set_process(false)
	player_sprite.stop()


func restart_game() -> void:
	# pause before showing menu
	yield(get_tree().create_timer(1.5), "timeout")

	# unfreeze and delete player
	player.set_physics_process(true)
	player_sprite.set_process(true)
	player.queue_free()
	
	# reset clock
	reset_stopwatch()

	# restart game
	get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")


func reset_stopwatch() -> void:
	Global.stopwatch = 0
