extends Area2D

signal enemy_died(area, position)
signal bullet_fired(bullet)

export var speed = 0
var velocity = Vector2()
var screen_size
var player_reference

# Called when the node enters the scene tree for the first time.
func _ready():
    screen_size = get_viewport().size
    # $AnimatedSprite.play("move")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    update_velocity(delta)
    move(delta)
    shoot(delta)

func move(delta):
    position += velocity * speed * delta
    adjust_position(position, screen_size)
    #position.x = handle_x(position.x)
    if position.y >= screen_size.y:
        emit_signal("enemy_escaped")

func adjust_position(position, screen_size):
    position.x = clamp(position.x, 0, screen_size.x)

func _on_Area2D_area_entered(area):
    emit_signal("enemy_died", area, position)
    queue_free()


## Optional Functions that can be overwritten if needed
func update_velocity(delta):
    pass

func shoot(delta):
    pass
