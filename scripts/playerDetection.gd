extends Area2D

var player = null

#if area is does not see player, script returns null/false
#otherwise, returns !null/true

func can_see_player():
	return player != null

func _on_PlayerDetectionZone_body_entered(body):
	player = body

func _on_PlayerDetectionZone_body_exited(body):
	player = null
