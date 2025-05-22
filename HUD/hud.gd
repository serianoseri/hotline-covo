extends CanvasLayer

@onready var bullet_amount: Label = $Bullet_HUD/Bullet_amount

func create_ammo(max_ammo: int):
	bullet_amount.text = str(max_ammo)

func update_ammo(amount : int):
	bullet_amount.text = str(amount)
