extends PanelContainer

@onready var cell_node : PackedScene = preload("res://scenes/cell.tscn")

@onready var start: Button = $InterfaceMargin/MainContainer/ButtonContainer/Start
@onready var stop: Button = $InterfaceMargin/MainContainer/ButtonContainer/Stop

@onready var row_value: SpinBox = $InterfaceMargin/MainContainer/ControlContainer/RowContainer/RowValue
@onready var col_value: SpinBox = $InterfaceMargin/MainContainer/ControlContainer/ColContainer/ColValue

@onready var grid: GridContainer = $InterfaceMargin/MainContainer/Grid

@onready var update_timer: Timer = $UpdateTimer

func _ready() -> void :
	get_window().min_size = Vector2i(500, 500)
	
	start.pressed.connect(_on_start_pressed)
	stop.pressed.connect(_on_stop_pressed)
	
	row_value.value_changed.connect(_resize_grid)
	col_value.value_changed.connect(_on_col_value_changed)
	
	update_timer.timeout.connect(_on_update_timer_timeout)

func _on_start_pressed() -> void :
	update_timer.start()

func _on_stop_pressed() -> void :
	update_timer.stop()

func _on_update_timer_timeout() -> void :
	CellManager.update_cell_data.emit()

func _on_col_value_changed(value : int) -> void :
	grid.columns = value
	_resize_grid(value)

func _resize_grid(_value : int) -> void:
	for child in grid.get_children():
		grid.remove_child(child)
	
	var row = row_value.value
	var col = col_value.value
	var no_of_cells = row * col
	
	for cell in range(no_of_cells):
		grid.add_child.call_deferred(cell_node.instantiate())
