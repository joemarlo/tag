extends CanvasLayer

onready var StopwatchBar = get_node("Control/StopwatchBar")
onready var StopwatchText = get_node("Control/StopwatchText")
export (Color) var color_high = Color("#8cb6ecb3")
export (Color) var color_low = Color("#8cd73838")

var stopwatch_range = [-20, 20]


func _ready():
	update_range()


func _process(delta):
	update_bar()
	update_text()
	update_text_position()


func update_range() -> void:
	StopwatchBar.min_value = stopwatch_range[0]
	StopwatchBar.max_value = stopwatch_range[1]


func update_bar() -> void:
	StopwatchBar.value = Global.stopwatch
	if Global.stopwatch > 0:
		StopwatchBar.tint_progress = color_high
	else:
		StopwatchBar.tint_progress = color_low
	var bar_percentage = abs(StopwatchBar.value) / stopwatch_range[1] # assumes symmetry 
	bar_percentage = 0.5 + (bar_percentage / 2) # TODO: need a non-linear way
	StopwatchBar.modulate.a =  bar_percentage


func update_text() -> void:
	StopwatchText.text = "%0.2f" % Global.stopwatch
	if Global.stopwatch > 0:
		StopwatchText.add_color_override("font_color", Color("#6bb572"))
	else:
		StopwatchText.add_color_override("font_color", Color("#c24c4c"))


# TODO: text position can be greater than 1 and go off the bar
func update_text_position() -> void:
	var container_height = StopwatchBar.rect_size.y
	var offset = (container_height / 2) - 20
	var bar_percentage = calculate_bar_percentage(Global.stopwatch, stopwatch_range)
	StopwatchText.rect_position.y = offset + -bar_percentage * container_height


func calculate_bar_percentage(stopwatch, stopwatch_range) -> float:
	var bar_percentage = stopwatch / (stopwatch_range[1] - stopwatch_range[0])
	bar_percentage = max(-0.5, min(0.5, bar_percentage))
#	range is -0.5, 0.5 for some reason
	return bar_percentage
