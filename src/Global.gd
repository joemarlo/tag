extends Node

var stopwatch = 0.0 
var stopwatch_range = [-25, 25]


func _reset_game() -> void:
	get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")
	Global.stopwatch = 0.0


func _flash_sprite(_sprite) -> void:
	for i in range(4):
		_sprite.modulate = Color("#f25c5c")
		yield(get_tree().create_timer(0.08), "timeout")
		_sprite.modulate = Color(1, 1, 1)
		yield(get_tree().create_timer(0.08), "timeout")


func _freeze(character, character_sprite) -> void:
	character.set_physics_process(false)
	character.set_process(false)
	character_sprite.set_process(false)
	character_sprite.stop()


func _unfreeze(character, character_sprite) -> void:
	character.set_physics_process(true)
	character.set_process(true)
	character_sprite.set_process(true)
