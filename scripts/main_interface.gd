extends PanelContainer

@onready var start: Button = $InterfaceMargin/MainContainer/ButtonContainer/Start
@onready var stop: Button = $InterfaceMargin/MainContainer/ButtonContainer/Stop
@onready var update_timer: Timer = $UpdateTimer

func _ready() -> void :
	get_window().min_size = Vector2i(500, 500)
	
	start.pressed.connect(_on_start_pressed)
	stop.pressed.connect(_on_stop_pressed)
	update_timer.timeout.connect(_on_update_timer_timeout)

func _on_start_pressed() -> void :
	update_timer.start()

func _on_stop_pressed() -> void :
	update_timer.stop()

func _on_update_timer_timeout() -> void :
	CellManager.update_cell_data.emit()
