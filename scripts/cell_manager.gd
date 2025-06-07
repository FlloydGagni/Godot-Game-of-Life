extends Node

@warning_ignore("unused_signal")

var row : int
var col : int
var no_of_cells : int

var grid_map : Dictionary
var current_status_map : Dictionary
var next_status_map : Dictionary

func update_cell_data() -> void :
	for cell in grid_map:
		var alive_neighbors_count = 0
		
		current_status_map[Vector2i(grid_map[cell].cell_location)] = grid_map[cell].alive
		
		for neighbor in grid_map[cell].cell_neighbors:
			if grid_map[neighbor].alive :
				alive_neighbors_count += 1
		
		if current_status_map[Vector2i(grid_map[cell].cell_location)] == true :
			if alive_neighbors_count < 2 or alive_neighbors_count > 3 :
				next_status_map[Vector2i(grid_map[cell].cell_location)] = false
			elif alive_neighbors_count == 2 or alive_neighbors_count == 3 :
				next_status_map[Vector2i(grid_map[cell].cell_location)] = true
		elif current_status_map[Vector2i(grid_map[cell].cell_location)] == false :
			if alive_neighbors_count == 3 :
				next_status_map[Vector2i(grid_map[cell].cell_location)] = true
			else :
				next_status_map[Vector2i(grid_map[cell].cell_location)] = false
	
	for cell in grid_map:
		grid_map[cell].alive = next_status_map[Vector2i(grid_map[cell].cell_location)]
		grid_map[cell]._update_cell_display()
