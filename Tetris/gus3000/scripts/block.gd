extends Node2D
class_name Block

enum BlockType {I, O, T, S, Z, J, L}
enum Rotation {NORTH, EAST, SOUTH, WEST}
@export var type: BlockType

var I_BLOCK: Texture2D = preload ("res://art/tetris_block_I.tres")
var O_BLOCK: Texture2D = preload ("res://art/tetris_block_O.tres")
var T_BLOCK: Texture2D = preload ("res://art/tetris_block_T.tres")
var L_BLOCK: Texture2D = preload ("res://art/tetris_block_L.tres")
var J_BLOCK: Texture2D = preload ("res://art/tetris_block_J.tres")
var Z_BLOCK: Texture2D = preload ("res://art/tetris_block_Z.tres")
var S_BLOCK: Texture2D = preload ("res://art/tetris_block_S.tres")

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

func _process(delta):
	pass

func update_pos():
	position = Vector2(
		GameConstants.BLOCK_SIZE * pos_grid_x,
		GameConstants.BLOCK_SIZE * pos_grid_y
	)
	position += get_delta_from_type() * GameConstants.BLOCK_SIZE
	print("grid pos : ", pos_grid_x, ",", pos_grid_y)
	print("world pos : ", position.x, ",", position.y)

func down():
	pos_grid_y += 1
	update_pos()

func get_delta_from_type() -> Vector2:
	match (type):
		BlockType.I:
			return Vector2()
		BlockType.O:
			return Vector2()
		BlockType.T, BlockType.L, BlockType.J, BlockType.Z, BlockType.S:
			return Vector2( - 0.5, 0.5)
		_:
			print("type not found :", type)
			return Vector2(0, 0)

func get_texture_from_type() -> Texture2D:
	match type:
		BlockType.I:
			return I_BLOCK
		BlockType.O:
			return O_BLOCK
		BlockType.T:
			return T_BLOCK
		BlockType.L:
			return L_BLOCK
		BlockType.J:
			return J_BLOCK
		BlockType.Z:
			return Z_BLOCK
		BlockType.S:
			return S_BLOCK
		_:
			print("type not found :", type)
			return null
