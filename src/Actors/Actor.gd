extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP #Vector2(0, -1)

var speed: = Vector2(900.0, 1400.0)
var gravity: = 1500.0

var _velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
