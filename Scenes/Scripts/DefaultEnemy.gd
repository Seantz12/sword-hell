extends "res://Scenes/Scripts/BaseEnemy.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    velocity.x = 0
    velocity.y = rand_range(0.5, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
