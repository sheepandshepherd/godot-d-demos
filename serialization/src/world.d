module world;

import sector, chunk, coordinate;

import godot, godot.node, godot.spatial, godot.gridmap;
import godot.projectsettings;

import cerealed;

class VoxelWorld : GodotScript!GridMap
{
	@Method _ready()
	{
		Sector testSector = new Sector(Coordinate(0,0,0));
		testSector.generate();

		ubyte[] bytes = testSector.cerealize();
		print("Length of testSector: ", bytes.length, " bytes");

		import std.file;
		write("testSector.dat", bytes);
	}
}


