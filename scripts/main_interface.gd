extends PanelContainer

@onready var cell_node : PackedScene = preload("res://scenes/cell.tscn")

@onready var start: Button = $InterfaceMargin/MainContainer/ButtonContainer/Start
@onready var stop: Button = $InterfaceMargin/MainContainer/ButtonContainer/Stop

@onready var row_value: SpinBox = $InterfaceMargin/MainContainer/ControlContainer/RowContainer/RowValue
@onready var col_value: SpinBox = $InterfaceMargin/MainContainer/ControlContainer/ColContainer/ColValue

@onready var grid: GridContainer = $InterfaceMargin/MainContainer/Grid

@onready var update_timer: Timer = $UpdateTimer

var row : int = 1
var col : int = 1
var no_of_cells : int = 1

func _ready() -> void :
	get_window().min_size = Vector2i(500, 500)
	
	_resize_grid(0)
	
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
	CellManager.update_cell_data()

func _on_col_value_changed(value : int) -> void :
	grid.columns = value
	_resize_grid(0)

func _resize_grid(_value : int) -> void:
	CellManager.grid_map = {}
	
	row = int(row_value.value)
	CellManager.row = row
	
	col = int(col_value.value)
	CellManager.col = col
	
	no_of_cells = row * col
	CellManager.no_of_cells = no_of_cells
	
	for child in grid.get_children():
		child.queue_free()
	
	for row_index in range(row):
		for col_index in range(col):
			CellManager.grid_map[Vector2i(row_index, col_index)] = cell_node.instantiate()
			
			var current_cell_node = CellManager.grid_map[Vector2i(row_index, col_index)]
			current_cell_node._initialize_cell_location(Vector2i(row_index, col_index))
			
			grid.add_child.call_deferred(current_cell_node)
