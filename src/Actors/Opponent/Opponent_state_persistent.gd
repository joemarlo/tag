extends KinematicBody2D
class_name Opponent_state_persistent

# https://docs.godotengine.org/en/stable/tutorials/misc/state_design_pattern.html

onready var player = get_node("/root/LevelCity/Player")
onready var player_sprite = player.get_node("AnimatedSprite")
onready var opponent = get_node("/root/LevelCity/Opponent")
onready var opponent_sprite = opponent.get_node("AnimatedSprite")

var state
var state_factory


func _ready():
	state_factory = Opponent_state_factory.new()
	change_state("evade")


func _physics_process(delta):
	#change_state("evade")
	pass

func _on_TagDetector_area_entered(body: PhysicsBody2D) -> void:
	swap_state()
#	move_chaser_back()
	freeze_chaser()



func swap_state() -> void:
	if state.name == 'evade':
		change_state("chase")
	elif state.name == 'chase':
		change_state("evade")
	else:
		printerr("Error: Opponent state somehow neither evade or chase")


# TODO: need to interpolate but this is outside a _process function
func move_chaser_back() -> void:
	if state.name == 'evade':
		var position_new = opponent.get_position() + Vector2(100, 0) #player.get_position()
		opponent.set_position(opponent.position.linear_interpolate(position_new)) 
	elif state.name == 'chase':
		var position_new = player.get_position() + Vector2(100, 0) #
		player.set_position(player.position.linear_interpolate(position_new))
	else:
		printerr("Error: Opponent state somehow neither evade or chase")


func freeze_chaser() -> void:
	if state.name == 'evade':
		freeze_character(opponent, opponent_sprite)
	if state.name == 'chase':
		freeze_character(player, player_sprite)
	else:
		printerr("freeze_chaser() error: Opponent state somehow neither evade or chase")


func freeze_character(character, character_sprite) -> void:
		character.set_physics_process(false)
		character_sprite.set_process(false)
		character_sprite.stop()
		
		flash_sprite(character_sprite)
		yield(get_tree().create_timer(1), "timeout")
		
		character.set_physics_process(true)
		character_sprite.set_process(true)


func flash_sprite(sprite) -> void:
	sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	sprite.modulate = Color("#f2e1e1")
	yield(get_tree().create_timer(0.08), "timeout")
	sprite.modulate = Color("#f25c5c")
	yield(get_tree().create_timer(0.08), "timeout")
	sprite.modulate = Color("#f2e1e1")
	


func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	#state.setup(funcref(self, "change_state"), $opponent_sprite, self)
	state.name = new_state_name
	add_child(state)

