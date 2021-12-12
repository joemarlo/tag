extends Actor
class_name Enemy

var kill_time_bonus = 3
var label_color = Color("#0fab3e")
var d_start = 0.0
var d_end = 0.0
onready var player = get_node("/root/LevelCity/Player")
onready var timeAddedLabel = player.get_node('TimeAdded')
onready var _sprite = $enemy


 # overrides native class when calling this function
func get_class(): return "Enemy"


func _init():
	speed = Vector2(600.0, 1400.0)


func _ready() -> void:
	add_to_group("Enemies")
	set_physics_process(false)
	_velocity.x = -speed.x


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	# bounce off walls
	if is_on_wall():
		_velocity *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	
	# don't do anything if below the object
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	
	# add time bonus
	time_bonus()
	
	# otherwise shake camera and delete the node (i.e. kill enemy)
	get_node("../Player/Camera2D").add_trauma(0.45)
	queue_free()


func time_bonus() -> void:
	# add time to stopwatch
	Global.stopwatch += kill_time_bonus
	
	# create label TODO: this doesn't disappear
#	timeAddedLabel.show()
#	yield(get_tree().create_timer(1), "timeout")
#	timeAddedLabel.hide()


func freeze() -> void:
	Global._freeze(self, _sprite)
func unfreeze() -> void:
	Global._unfreeze(self, _sprite)
