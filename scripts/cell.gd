extends Control

@export var cell_data : Dictionary

@onready var cell_panel: Panel = $CellPanel
@onready var location_label: Label = $CellPanel/Location

var alive : bool = false
var cell_location : Vector2i
var cell_neighbors : Array[Vector2i]

func _ready() -> void:
	cell_data = {
		"status" : alive,
		"location" : cell_location,
		"neighbors" : cell_neighbors,
	}
	
	CellManager.update_cell_data.connect(_on_update_cell_data)

func _initialize_cell_location(grid_location : Vector2i) -> void :
	cell_location = grid_location
	$CellPanel/Location.text = str(cell_location)
	
	_initialize_neighbors()

func _on_update_cell_data() -> void :
	CellManager.current_cell_data.emit(cell_data)

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
	
	cell_data["neighbors"] = cell_neighbors
