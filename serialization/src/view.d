module view;

import godot;
import godot.node, godot.camera, godot.spatial;

import godot.inputevent;

class View : GodotScript!Spatial
{
	@Method _unhandledInput(Ref!InputEvent e)
	{
	}
}

