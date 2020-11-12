extends KinematicBody2D

var movespeed = 500
var bullet_speed = 1000
var bullet = preload("res://Bullet.tscn")
var enemigo = preload("res://Enemy.tscn")

func _ready():
	pass
	
func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -=1
	if Input.is_action_pressed("down"):
		motion.y +=1
	if Input.is_action_pressed("right"):
		motion.x +=1
	if Input.is_action_pressed("left"):
		motion.x -=1
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)

	look_at(get_global_mouse_position())
	var enemigosVivos = get_tree().get_nodes_in_group("Enemigos").size()
	get_node("../CanvasLayer/Label").text = "Enemigos vivos: " + str(enemigosVivos)
	if enemigosVivos == 0:
		get_node("../CanvasLayer/Button").visible = true
#	print( get_tree().get_nodes_in_group("Enemigos").size() )
	
	if Input.is_action_just_pressed("LMB"):
		fire()

func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(),Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)

func kill():
	get_tree().reload_current_scene()

func _on_Area2D_body_entered(body):
	if "Enemy" in body.name:
		kill()


func _on_Button_pressed():
	get_tree().reload_current_scene()

export (PackedScene) var nivel2
func _on_Button2_pressed():
	get_tree().change_scene_to(nivel2)



func _on_Button3_pressed():
	print (get_tree().change_scene("res://elcoso.tscn"))
#	get_tree().reload_current_scene()
#	get_tree().change_scene_to("res://elcoso.tscn")
