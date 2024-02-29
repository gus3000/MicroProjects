extends GridContainer

@export var grid_size: Vector2i
@export_range(0, 100) var bomb_percentage: float

@export var case: PackedScene

var case_buttons: Array # Case[][]
var bombs: Array # bool[][]
var revealed: Array # bool[][]

func _ready() -> void:
	ready_model_grid()
	ready_button_grid()

func ready_model_grid() -> void:
	print("bomb percentage : ", bomb_percentage)
	var grid_len = grid_size.x * grid_size.y
	var number_of_bombs: int = grid_len * (bomb_percentage / 100)
	
	# Put the bombs at the beginning of the grid, then shuffle it
	var bombs_put = 0
	bombs = []
	revealed = []
	for row in range(grid_size.y):
		bombs.append([])
		revealed.append([])
		for col in range(grid_size.x):
			if bombs_put < number_of_bombs:
				bombs[row].append(true)
				bombs_put += 1
			else:
				bombs[row].append(false)
			revealed[row].append(false)
	
	print_bombs()

	for row in range(grid_size.y):
		for col in range(grid_size.x):
			var swap_x = randi_range(0, grid_size.x - 1)
			var swap_y = randi_range(0, grid_size.y - 1)

			var was_bomb = is_bomb(swap_x, swap_y)
			bombs[swap_y][swap_x] = is_bomb(col, row)
			bombs[row][col] = was_bomb
	
	print_bombs()

func ready_button_grid() -> void:
	columns = grid_size.x
	case_buttons = []
	for y in range(grid_size.y):
		case_buttons.append([])
		for x in range(grid_size.x):
			var c: Case = case.instantiate()
			case_buttons[y].append(c)
			add_child(c)
			# c.set_text("%d,%d" % [x, y])
			c.pressed.connect(pressed_button.bind(x, y))

func print_bombs() -> void:
	var s = ""
	for row in range(grid_size.y):
		for col in range(grid_size.x):
			s += ("X" if is_bomb(col, row) else "_")
		s += "\n"
	
	print(s)

func is_bomb(x: int, y: int) -> bool:
	return bombs[y][x]

func get_case(x: int, y: int) -> Case:
	return case_buttons[y][x]

func neighbor_bombs(x: int, y: int) -> int:
	var number_of_bombs = 0
	for yy in range(y - 1, y + 2):
		for xx in range(x - 1, x + 2):
			if not in_grid(xx, yy):
				continue
			if is_bomb(xx, yy):
				number_of_bombs += 1
	return number_of_bombs

func in_grid(x: int, y: int) -> bool:
	if x < 0 or x >= grid_size.x:
		return false
	if y < 0 or y >= grid_size.y:
		return false
	return true

func pressed_button(x: int, y: int) -> void:
	if bombs[y][x]:
		print("boum")
		# TODO handle game over
		return
	
	reveal(x, y)

func reveal(x: int, y: int) -> void:
	if not in_grid(x, y):
		return
	if revealed[y][x]:
		return
	revealed[y][x] = true
	var c = get_case(x, y)
	var close_bombs = neighbor_bombs(x, y)
	c.set_text(str(close_bombs))
	if close_bombs == 0:
		for yy in range(y - 1, y + 2):
			for xx in range(x - 1, x + 2):
				reveal(xx, yy)
	