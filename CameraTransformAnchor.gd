extends RemoteTransform3D
class_name CameraPlayerAnchor

##Dont touch this
var player: Player

var current_parent: Node3D

func init():
	if player:
		player.camera_anchor = self

func _reparent_camera(new_parent: Node3D):
	self.reparent(new_parent)
	self.current_parent = get_parent()

func _return_to_player():
	self.reparent(player)
	self.current_parent = player
