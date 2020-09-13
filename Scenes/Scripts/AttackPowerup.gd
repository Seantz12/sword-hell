extends Area2D

signal on_pickedup(type, duration)

const time_until_gone = 10
var current_time = 0

const powerup_duration = 10

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    current_time += delta
    if current_time > time_until_gone:
        queue_free()


func _on_Area2D_area_entered(area):
    print("picked up")
    emit_signal("on_pickedup", "ranged", powerup_duration)
    queue_free()
