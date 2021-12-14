extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP #Vector2(0, -1)

var speed: = Vector2(700.0, 1200.0)
var gravity: = 1700.0

var _velocity: = Vector2.ZERO

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
