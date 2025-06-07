extends Control

signal update_cell_data(cell_data : Dictionary)

@export var cell_data : Dictionary

@onready var cell_panel: Panel = $CellPanel
@onready var update_timer: Timer = $UpdateTimer

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
	
	update_timer.timeout.connect(_on_update_timer_timeout)

func _on_update_timer_timeout():
	update_cell_data.emit(cell_data)

func _initialize_cell_location(grid_location : Vector2i) -> void :
	cell_location = grid_location
