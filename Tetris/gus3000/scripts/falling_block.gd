extends Node2D
class_name FallingBlock

@export var type: Block.Type
@export var block_rotation: Block.Rotation

var sprite: Sprite2D
var pos_grid_x: int
var pos_grid_y: int

func _ready():
	print("instantiating block of type ", type)
	update_pos()
	pass
	#position.x = get_viewport_rect().size.x / 2
	
	# var texture = get_texture_from_type()
	# sprite = Sprite2D.new()
	# sprite.texture = texture
	# sprite.centered = false
	# add_child(sprite)

func _process(_delta):
	pass

func update_pos():
	position = Vector2(
		GameConstants.BLOCK_SIZE * pos_grid_x,
		GameConstants.BLOCK_SIZE * pos_grid_y
	)
	position += get_delta_from_type() * GameConstants.BLOCK_SIZE
	print("grid pos : ", pos_grid_x, ",", pos_grid_y)
	print("world pos : ", position.x, ",", position.y)
	print("occupied space : ", occupied_space())


func down():
	pos_grid_y += 1
	update_pos()

func rotate_block():
	print("rotate")

func get_delta_from_type() -> Vector2:
	match (type):
		Block.Type.I:
			return Vector2()
		Block.Type.O:
			return Vector2()
		Block.Type.T, Block.Type.L, Block.Type.J, Block.Type.Z, Block.Type.S:
			return Vector2( - 0.5, 0.5)
		_:
			print("type not found :", type)
			return Vector2(0, 0)

func side_length() -> int:
	var occupied = GameConstants.SPACE_OCCUPIED[type][block_rotation]
	return ceil(sqrt(len(occupied)))

func occupied_space_local() -> Array:
	var occupied_matrix = GameConstants.SPACE_OCCUPIED[type][block_rotation]
	var side_len = side_length()
	var occupied_list = []
	for y in range(side_len):
		for x in range(side_len):
			if occupied_matrix[y*side_len + x] == 1:
				occupied_list.append(Vector2i(x, y))
	return occupied_list

func occupied_space() -> Array:
	var occupied_local = occupied_space_local()
	var occupied = []

	for o in occupied_local:
		occupied.append(Vector2i(o.x + pos_grid_x, o.y + pos_grid_y))

	return occupied
