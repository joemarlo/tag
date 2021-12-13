extends CanvasLayer

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
	$Win.show()
	restart_game()


func lose_game() -> void:
	freeze_game()
	$Lose.show()
	restart_game()


func freeze_game() -> void:
	player.freeze()
	opponent.freeze()
	freeze_enemies()


func restart_game() -> void:
	
	# disable input and pause
	get_tree().get_root().set_disable_input(true)
	yield(get_tree().create_timer(3), "timeout")
	
	# unfreeze characters
	get_tree().get_root().set_disable_input(false)
	player.unfreeze()
	opponent.unfreeze()
	unfreeze_enemies()
	
	Global._reset_game()


func freeze_enemies() -> void:
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.freeze()
func unfreeze_enemies() -> void:
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.unfreeze()
