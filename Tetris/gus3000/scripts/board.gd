extends Node2D

@export var update_time_ms: int = 1000
@export var block_prefabs: Array[PackedScene]

const GRID_WIDTH = 10
const GRID_HEIGHT = 20

var last_update: int
var current_block: FallingBlock = null
var grid: Array[Array] # Array[Array[bool]]

func _ready():
	spawn_block()
	last_update = Time.get_ticks_msec()

func spawn_block():
	# current_block = random_block()
	current_block = block_from_type(Block.Type.T)
	#current_block.position.x = get_viewport_rect().size.x / 2
	var delta_x = 0
	match current_block.type:
		Block.Type.I, Block.Type.O:
			delta_x = 0
		_:
			delta_x = 0
	
	current_block.pos_grid_x = (GRID_WIDTH / 2) + delta_x
	current_block.pos_grid_y = 0

	#current_block.position += GameConstants.BLOCK_SIZE * delta_x * Vector2.RIGHT
	add_child(current_block)

func random_block() -> Block:
	return block_prefabs.pick_random().instantiate()
	# return block_prefabs[0].instantiate()

func block_from_type(type: Block.Type) -> FallingBlock:
	return block_prefabs[type].instantiate()

func _process(_delta):
	var current_time = Time.get_ticks_msec()
	handle_input()
	if (current_time - last_update) >= update_time_ms:
		print("last update : ", last_update, ", current_time : ", current_time)
		update()

func handle_input():
	if Input.is_action_just_pressed("rotate_cw"):
		current_block.rotate_block()

func update():
	last_update += update_time_ms
	print("update")
	current_block.down()
