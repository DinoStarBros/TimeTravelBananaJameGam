extends Node

const bananarang_scn : PackedScene = preload("res://Projectiles/BananaRang/banana_rang.tscn")
const hitspark_scn : PackedScene = preload("res://Juices/hitspark/hitspark.tscn")
const big_cleave_scn : PackedScene = preload("res://Juices/BigCleave/big_cleave.tscn")
const txt_scn : PackedScene = preload("res://Juices/DmgNum/dmg_num.tscn")
const click_boom_scn : PackedScene = preload("res://Juices/ClickBoom/click_boom.tscn")
const clock_boom_scn : PackedScene = preload("res://Projectiles/ClockBoom/clock_boom.tscn")
const enemy_projectile_scn : PackedScene = preload("res://Projectiles/EnemyProjectile/enemy_projectile.tscn")
const reflected_projectile_scn : PackedScene = preload("res://Projectiles/ReflectedProjectile/reflected_projectile.tscn")

const enemy_scns : Array[PackedScene] = [
	preload("res://Entities/Chaser/chaser.tscn"),
	preload("res://Entities/Dashie/dashie.tscn"),
	preload("res://Entities/Shooty/shooty.tscn"),
	
]
