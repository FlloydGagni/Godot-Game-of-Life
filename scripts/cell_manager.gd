extends Node

@warning_ignore("unused_signal")

signal update_cell_data
signal current_cell_data(cell_data : Dictionary)
signal update_current_cell_data

var alive : bool = false
var cell_location : Vector2i
var cell_neighbors : Array[Vector2i]
var grid_map : Dictionary
var row : int
var col : int
var no_of_cells : int

func _ready() -> void:
	self.current_cell_data.connect(_on_current_cell_data)

func _on_current_cell_data(cell_data : Dictionary) -> void:
	alive = cell_data["status"]
	cell_location = cell_data["location"]
	cell_neighbors = cell_data["neighbors"]
	
	var alive_neighbors_count = 0
	
	print(cell_neighbors)
	
	for neighbor in cell_neighbors:
		var neighbor_cell_node = grid_map[neighbor]
		print(neighbor_cell_node.alive)
		print("")
		
		if neighbor_cell_node.alive:
			alive_neighbors_count += 1
	
	if alive_neighbors_count < 2 or alive_neighbors_count > 3:
		alive = false
	elif alive_neighbors_count == 2 or alive_neighbors_count == 3:
		alive = true
	
	update_current_cell_data.emit(alive)
