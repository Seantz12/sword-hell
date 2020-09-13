extends Area2D

export var speed = -300
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
    screen_size = get_viewport().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position.y += speed * delta
    if position.y <= 0:
        queue_free()
