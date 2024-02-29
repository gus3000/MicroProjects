extends TextureButton
class_name Case

@onready var label: Label = $"Label"

func _ready():
    set_text("")

func set_text(t: String):
    label.text = t
