extends Node2D

enum BlockType {I, O, T, L, J, Z, S}
@export var type: BlockType

var I_BLOCK: Texture2D = preload ("res://art/tetris_block_I.tres")
var O_BLOCK: Texture2D = preload ("res://art/tetris_block_O.tres")
var T_BLOCK: Texture2D = preload ("res://art/tetris_block_T.tres")
var L_BLOCK: Texture2D = preload ("res://art/tetris_block_L.tres")
var J_BLOCK: Texture2D = preload ("res://art/tetris_block_J.tres")
var Z_BLOCK: Texture2D = preload ("res://art/tetris_block_Z.tres")
var S_BLOCK: Texture2D = preload ("res://art/tetris_block_S.tres")

var sprite: Sprite2D

func _ready():
	var texture = get_texture_from_type()
	sprite = Sprite2D.new()
	sprite.texture = texture
	sprite.centered = false
	add_child(sprite)

func _process(delta):
	rotate(delta)

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
