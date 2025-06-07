extends Control

@export var cell_data : Dictionary

@onready var cell_panel: Panel = $CellPanel

var alive : bool = false
var cell_location : Vector2i
var cell_neighbors : Array[Vector2i]

func _ready() -> void:
	_update_cell_data()
	_update_cell_display()
	
	cell_panel.gui_input.connect(_on_gui_input)

func _update_cell_data() -> void :
	cell_data = {
		"status" : alive,
		"location" : cell_location,
		"neighbors" : cell_neighbors,
	}

func _initialize_cell_location(grid_location : Vector2i) -> void :
	cell_location = grid_location
	
	_initialize_neighbors()

func _initialize_neighbors() -> void :
	var directions : Array[Vector2i] = [
		Vector2i(-1, -1), Vector2i(-1, 0), Vector2i(-1, 1),
		Vector2i(0, -1),                 Vector2i(0, 1),
		Vector2i(1, -1),  Vector2i(1, 0), Vector2i(1, 1)
	]
	
	cell_neighbors.clear()
	
	for dir in directions:
		var neighbor : Vector2i = cell_location + dir
		
		
		# Ensure the neighbor is within bounds
		if neighbor.x >= 0 and neighbor.x < CellManager.row and neighbor.y >= 0 and neighbor.y < CellManager.col:
			cell_neighbors.append(neighbor)
	
	_update_cell_data()

func _update_cell_display() -> void :
	var stylebox = StyleBoxFlat.new()
	
	if alive:
		stylebox.bg_color = Color(0.6, 0.6, 0.6)  # Green when alive
	else:
		stylebox.bg_color = Color(0.3, 0.3, 0.3)
	
	cell_panel.add_theme_stylebox_override("panel", stylebox)

func _on_gui_input(event : InputEvent) -> void :
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			alive = !alive
			_update_cell_display()
