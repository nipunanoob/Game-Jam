extends RigidBody2D


onready var sprite = $Sprite
onready var lazer_muzzle = $LazerMuzzle



var collision_point
var contact := false
var speed = 4.8

var is_grounded = false
var is_walled = false

var energy = 100
var count = 0

onready var ground_ray1 = $GroundRay
onready var ground_ray2 = $GroundRay2
onready var ground_ray3 = $GroundRay3

	
func update_grounded():
#	ground_ray.force_raycast_update()
	is_grounded = ground_ray1.is_colliding() or ground_ray2.is_colliding() or ground_ray3.is_colliding()
	
		

func _physics_process(delta):
	update_grounded()
	lazer_muzzle.look_at(get_global_mouse_position())
		
	if(is_grounded == true):
		refuel()
		
	
	
	
	
func _on_LazerBeam_propel_player(point):
	collision_point = point
	contact = true
	


func _integrate_forces(state):
	if contact:
		var impulse = -(get_global_mouse_position() - $CollisionShape2D.global_position).normalized() * speed
		apply_central_impulse(impulse * speed) 
	


func _on_LazerBeam_stop_propel_player():
	contact = false

func refuel():
	energy = 100
	update_fuel_UI(energy)
	
func use_fuel():
	energy -= 2
	energy = clamp(energy, 0, 100)
	update_fuel_UI(energy)
	if energy == 0:
		$LazerMuzzle/LazerBeam.is_casting = false


		
func _on_LazerBeam_use_fuel():
	use_fuel()
	
func update_fuel_UI(value):
	$UI/Energy/ProgressBar.value = value
	
