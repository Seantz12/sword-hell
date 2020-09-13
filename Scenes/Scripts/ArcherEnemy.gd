extends "res://Scenes/Scripts/BaseEnemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var time_between_shots = 3
var time_since_last_shot = 0
var arrow = preload("res://Scenes/ArcherArrow.tscn")
var facing_vector = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x = rand_range(-0.2, 0.2)
    velocity.y = rand_range(0.1, 0.2)
    $AnimatedSprite.connect("frame_changed", self, "animation_frame_changed")

func adjust_position(position, screen_size):
    if position.x < 0 || position.x > screen_size.x:
        velocity.x *= -1

func shoot(delta):
    time_since_last_shot += delta
    if time_since_last_shot > time_between_shots and player_reference:
        time_since_last_shot = 0
        
        # Turn and face the player
        var player_position = player_reference.position
        facing_vector = player_position - position
        rotation = facing_vector.angle() + PI/2
        facing_vector = facing_vector.normalized()
        $AnimatedSprite.play()

func animation_frame_changed():
    match $AnimatedSprite.frame:
        3:
            var new_arrow = arrow.instance()
            new_arrow.position = position
            new_arrow.velocity = facing_vector
            emit_signal("bullet_fired", new_arrow)
            $AnimatedSprite.frame = 0
            $AnimatedSprite.stop()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
