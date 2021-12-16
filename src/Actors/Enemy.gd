extends Actor
class_name Enemy

var kill_time_bonus = 3
var label_color = Color("#0fab3e")
onready var player = get_node("/root/LevelCity/Player")
onready var _sprite = $AnimatedSprite
onready var camera = get_node("../Player/Camera2D")


 # overrides native class when calling this function
func get_class(): return "Enemy"


func _init():
	speed = Vector2(400.0, 1200.0)


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
	flip_sprite(_velocity)


func _on_StompDetector_body_entered(body: PhysicsBody2D) -> void:
	
	# don't do anything if below the object
	if body.global_position.y > get_node("StompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	
	## otherwise
	# add time bonus
	body.time_added()
	
	# shake camera
	camera.add_trauma(0.45)
	
	# animate poof
	_sprite.play("poof")
	self.freeze()
	yield(get_tree().create_timer(0.4), "timeout")
	
	# delete the node
	queue_free()


func flip_sprite(velocity):
	if velocity.x < 0:
		_sprite.set_flip_h(true)
	elif velocity.x > 0:
		_sprite.set_flip_h(false)


func freeze() -> void:
	Global._freeze(self, _sprite)
func unfreeze() -> void:
	Global._unfreeze(self, _sprite)
