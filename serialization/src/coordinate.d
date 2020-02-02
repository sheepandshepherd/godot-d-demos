module coordinate;

import chunk, sector;

/++
Global coordinate that can represent any block in the world
+/
struct Coordinate
{
	long x, y, z;

	/// the chunk this coordinate is inside, local to its Sector
	Sector.Cell sectorCell() const
	{
		Sector.Cell c;
		c.x = (cast(ubyte)x) % Sector.size;
		c.y = (cast(ubyte)y) % Sector.size;
		c.z = (cast(ubyte)z) % Sector.size;
		return c;
	}

	/// this coordinate, local to its Chunk
	Chunk.Cell chunkCell() const
	{
		Chunk.Cell c;
		c.x = (cast(ubyte)x) % Chunk.size;
		c.y = (cast(ubyte)y) % Chunk.size;
		c.z = (cast(ubyte)z) % Chunk.size;
		return c;
	}


	/// construct from global coordinates
	this(long x, long y, long z)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	/// construct from a cell inside a Sector
	this(Sector sector, Sector.Cell cell)
	{
		this = sector.coordinate;
		x += cell.x * Chunk.size;
		y += cell.y * Chunk.size;
		z += cell.z * Chunk.size;
	}

	/// construct from a cell inside a Chunk
	this(Chunk chunk, Chunk.Cell cell)
	{
		this = chunk.coordinate;
		x += cell.x;
		y += cell.y;
		z += cell.z;
	}
}


