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
	change_state("chase")


func _physics_process(delta):
	#change_state("evade")
	pass


func _on_TagDetector_area_entered(body: PhysicsBody2D) -> void:
	# TODO: all bodies trigger this despite mask level
	swap_state()


func swap_state() -> void:
	if state.name == 'evade':
		change_state("chase")
	elif state.name == 'chase':
		change_state("evade")
	else:
		printerr("Error: Opponent state somehow neither evade or chase")


func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	#state.setup(funcref(self, "change_state"), $opponent_sprite, self)
	state.name = new_state_name
	add_child(state)

