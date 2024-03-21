extends Node

const BLOCK_SIZE = 16

var SPACE_OCCUPIED = {
    Block.Type.I: {
        Block.Rotation.NORTH: [
            0, 0, 0, 0,
            1, 1, 1, 1,
            0, 0, 0, 0,
            0, 0, 0, 0,
        ]
    },
    Block.Type.O: {
        Block.Rotation.NORTH: [
            0, 0, 0, 0,
            0, 1, 1, 0,
            0, 1, 1, 0,
            0, 0, 0, 0,
        ]
    },
    Block.Type.T: {
        Block.Rotation.NORTH: [
            0, 1, 0,
            1, 1, 1,
            0, 0, 0,
        ]
    },
    Block.Type.S: {
        Block.Rotation.NORTH: [
            0, 1, 1,
            1, 1, 0,
            0, 0, 0,
        ]
    },
    Block.Type.Z: {
        Block.Rotation.NORTH: [
            1, 1, 0,
            0, 1, 1,
            0, 0, 0,
        ]
    },
    Block.Type.J: {
        Block.Rotation.NORTH: [
            1, 0, 0,
            1, 1, 1,
            0, 0, 0,
        ]
    },
    Block.Type.L: {
        Block.Rotation.NORTH: [
            0, 0, 1,
            1, 1, 1,
            0, 0, 0,
        ]
    }
}

func _ready() -> void:
    generate_rotated_positions()
    # get_tree().quit()

func generate_rotated_positions() -> void:
    for block_type in SPACE_OCCUPIED:
        var base_rotation = SPACE_OCCUPIED[block_type][Block.Rotation.NORTH]
        var current_rotation = base_rotation
        print("Type ", block_type)
        print_matrix(current_rotation)
        for rotation in range(3):
            current_rotation = rotate_cw(current_rotation)
            SPACE_OCCUPIED[block_type][rotation + 1] = current_rotation
            print_matrix(current_rotation)
        # print(block_type, " -> ", SPACE_OCCUPIED[block_type])

func rotate_cw(position: Array) -> Array:
    # +y -> -x, +x -> -y
    var rotated = position.duplicate()
    var size: int = ceil(sqrt(len(rotated)))
    print("len = ", len(rotated), " -> size = ", size)
    for x in range(size):
        for y in range(size):
            var i = y * size + x
            var fx = y
            var fy = size - 1 - x
            var fi = fy * size + fx
            # print("rotated[", i, "] = position[", fi, "]")
            rotated[i] = position[fi]
    return rotated as Array[int]

func print_matrix(m: Array) -> void:
    var size: int = ceil(sqrt(len(m)))
    for line in size:
        print(", ".join(m.slice(line * size, (line + 1) * size)))