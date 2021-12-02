extends Popup


onready var player = get_node("Player")
var already_paused
var selected_menu

# start pause menu on intialize
func _ready():
	# pause game
	already_paused = get_tree().paused
	get_tree().paused = true
	# reset popup
	selected_menu = 0
	change_menu_color()
	# show popup
	popup()

func change_menu_color():
	$Resume.color = Color("#2e1a2e")
	$Restart.color = Color("#2e1a2e")
	$Quit.color = Color("#2e1a2e")
	
	match selected_menu:
		0:
			$Resume.color = Color("#bbabbb")
		1:
			$Restart.color = Color("#bbabbb")
		2:
			$Quit.color = Color("#bbabbb")


func _input(event):
	if not visible:
		if Input.is_action_just_pressed("menu"):
			# pause game
			already_paused = get_tree().paused
			get_tree().paused = true
			# reset popup
			selected_menu = 0
			change_menu_color()
			# show popup
			#player.set_process_input(false)
			popup()
	else:
		if Input.is_action_just_pressed("ui_down"):
			selected_menu = (selected_menu + 1) % 3;
			change_menu_color()
		elif Input.is_action_just_pressed("ui_up"):
			if selected_menu > 0:
				selected_menu = selected_menu - 1
			else:
				selected_menu = 2
			change_menu_color()
		elif Input.is_action_just_pressed("ui_accept"):
			match selected_menu:
				0:
					# resume game
					if not already_paused:
						get_tree().paused = false
					#player.set_process_input(true)
					hide()
				1:
					# restart game
					get_tree().change_scene("res://src/Levels/LevelTemplate.tscn")
					get_tree().paused = false
				2:
					# quit game
					get_tree().quit()
