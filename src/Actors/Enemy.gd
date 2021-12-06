extends Actor

var kill_time_bonus = 3
var label_color = Color("#0fab3e")


func _init():
	speed = Vector2(600.0, 1400.0)


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x


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


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
	# bounce off walls
	if is_on_wall():
		_velocity *= -1.0
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y


func time_bonus() -> void:
	# add time to stopwatch
	Global.stopwatch += kill_time_bonus
	
	# create label TODO: this doesn't show
	create_label()


func create_label() -> void:
	var label_node = Label.new()
	self.add_child(label_node)
	label_node.set_owner(get_tree().get_edited_scene_root())
	label_node.text = "+" + str(kill_time_bonus) + " sec"
#	label_node.rect_position = Vector2(0, 0)
	label_node.add_color_override("font_color", label_color)
	label_node.add_font_override("font", load('assets/fonts/FFFORWA.tres'))
#	print(label_node.text)
