extends Popup


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
	var color_base = Color("#2e1a2e")
	var color_highlight = Color("#bbabbb")
	
	$Resume.color = color_base
	$Restart.color = color_base
	$Quit.color = color_base
	
	match selected_menu:
		0:
			$Resume.color = color_highlight
		1:
			$Restart.color = color_highlight
		2:
			$Quit.color = color_highlight


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
					hide()
				1:
					# restart game
					reset_game()
					get_tree().paused = false
				2:
					# quit game
					get_tree().quit()

func reset_game() -> void:
	Global._reset_game()
