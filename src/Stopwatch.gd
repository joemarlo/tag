extends CanvasLayer

onready var StopwatchBar = get_node("Control/StopwatchBar")
onready var StopwatchText = get_node("Control/StopwatchText")
export (Color) var color_high = Color("#0fab3e")
export (Color) var color_low = Color("#cc1212")
var stopwatch_range = Global.stopwatch_range


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
	var bar_percentage = calculate_bar_percentage(Global.stopwatch, stopwatch_range)
	var alpha = color_intensity_curve(bar_percentage)
	StopwatchBar.modulate.a = alpha


func color_intensity_curve(bar_percentage) -> float:
	var intensity = abs(0.5 - bar_percentage)
	intensity = ((pow((intensity * 10), 2) / 25) + 0.5) * 2/3
	return intensity


func update_text() -> void:
	# update text
	var stopwatch = max(stopwatch_range[0], min(stopwatch_range[1], Global.stopwatch))
	StopwatchText.text = "%0.2f" % stopwatch
	
	# update text color
	var bar_percentage = calculate_bar_percentage(Global.stopwatch, stopwatch_range)
	var alpha = min(1, color_intensity_curve(bar_percentage) * 1.5)
	StopwatchText.modulate.a = alpha
	if Global.stopwatch > 0:
		StopwatchText.add_color_override("font_color", color_high)
	else:
		StopwatchText.add_color_override("font_color", color_low)


func update_text_position() -> void:
	var container_height = StopwatchBar.rect_size.y
	var offset = -20
	var bar_percentage = calculate_bar_percentage(Global.stopwatch, stopwatch_range)
	StopwatchText.rect_position.y = offset + container_height * (1 - bar_percentage)


func calculate_bar_percentage(stopwatch, stopwatch_range) -> float:
	var bar_percentage = (stopwatch - stopwatch_range[0]) / (stopwatch_range[1] - stopwatch_range[0])
	bar_percentage = max(0, min(1, bar_percentage))
	return bar_percentage


func add_to_stopwatch(delta) -> void:
	Global.stopwatch += delta;
