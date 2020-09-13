extends Node2D

signal powerup_changed(name, duration)
signal wave_fired(position)
signal died(position)

var attack_powerups = []

# Player variables
export var speed = 100
var health = 3

# Player states
var attacking = false
var recovering = false

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
    screen_size = get_viewport().size
    $AnimatedSprite.connect("frame_changed", self, "animation_frame_changed")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    move(delta)
    decrement_powerup_time(delta)
    attack()

func move(delta):
    var velocity = Vector2()
    if Input.is_action_pressed("move_north"):
        velocity.y -= 1
    if Input.is_action_pressed("move_south"):
        velocity.y += 1
    if Input.is_action_pressed("move_east"):
        velocity.x += 1
    if Input.is_action_pressed("move_west"):
        velocity.x -= 1
    if velocity.length() > 0:
        velocity = velocity.normalized()
    position += velocity * speed * delta
    position.y = clamp(position.y, 0, screen_size.y)
    position.x = clamp(position.x, 0, screen_size.x)

func decrement_powerup_time(delta):
    for powerup in attack_powerups:
        powerup[1] -= delta
        if powerup[1] <= 0:
            attack_powerups.erase(powerup)
            powerup[1] = 0
        emit_signal("powerup_changed", powerup[0], powerup[1])

func attack():
    if Input.is_action_pressed("attack") && !attacking && !recovering:
        $AnimatedSprite.play("attack")
        attacking = true

func animation_frame_changed():
    match $AnimatedSprite.frame:
        0:
            recovering = false # You're done recovering at frame 0
        2:
            if attacking:
                $Sword/SwordHitbox.set_deferred("disabled", false)
                do_attack_powerups()
        4:
            $Sword/SwordHitbox.set_deferred("disabled", true)
            attacking = false
            recovering = true
            $AnimatedSprite.play("attack", true)

func do_attack_powerups():
    for powerup in attack_powerups:
        if powerup[0] == "ranged":
            emit_signal("wave_fired", position)
            pass

func add_attack_powerup(powerup_name, duration):
    # check if duplicate
    for powerup in attack_powerups:
        if powerup[0] == powerup_name:
            powerup[1] = duration
            return

    # no duplicate
    attack_powerups.append([powerup_name, duration])

func _on_Node2D_area_entered(area):
    # should only be triggered by bullets and enemies
    print("hello")
    if !area.is_in_group("powerups"):
        emit_signal("died", position)    
