extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 100
var screen_size
var velocity

# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x += rand_range(-0.05, 0.05)
    velocity.y += rand_range(-0.05, 0.05)
    velocity = velocity.normalized()
    rotation = velocity.angle() + PI/2
    screen_size = get_viewport().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position += velocity * speed * delta
    if position.x < 0 or position.x > screen_size.x or position.y < 0 or position.y > screen_size.y:
        queue_free()


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
    queue_free()
    pass # Replace with function body.
