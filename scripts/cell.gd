extends Control

@export var cell_data : Dictionary

@onready var cell_panel: Panel = $CellPanel

var alive : bool = false
var cell_location : Vector2i
var cell_neighbors : Array[Vector2i]

func _ready() -> void:
	cell_neighbors = [
		Vector2i(cell_location.x - 1, cell_location.y - 1),
		Vector2i(cell_location.x - 1, cell_location.y),
		Vector2i(cell_location.x - 1, cell_location.y + 1),
		
		Vector2i(cell_location.x, cell_location.y - 1),
		Vector2i(cell_location.x - 1, cell_location.y + 1),
		
		Vector2i(cell_location.x + 1, cell_location.y - 1),
		Vector2i(cell_location.x + 1, cell_location.y),
		Vector2i(cell_location.x + 1, cell_location.y + 1),
	]
	
	cell_data = {
		"status" : alive,
		"location" : cell_location,
		"neighbors" : cell_neighbors,
	}
	
	CellManager.update_cell_data.connect(_on_update_cell_data)

func _initialize_cell_location(grid_location : Vector2i) -> void :
	cell_location = grid_location

func _on_update_cell_data() -> void :
	CellManager.current_cell_data.emit(cell_data)
