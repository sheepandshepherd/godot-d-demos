module sector;

import coordinate;
import chunk;

import std.stdio : File;

class Sector
{
	/// number of chunks per axis
	enum int size = 32;

	static struct Cell
	{
		ubyte x, y, z;
	}

private:
	Chunk[Cell] chunks;

public:
	/// the block in the low corner of this Sector
	Coordinate coordinate;

	ushort getBlock(Coordinate coordinate) const
	{
		Cell cell = coordinate.sectorCell;
		// FIXME: handle unloaded chunks
		return chunks[cell].getBlock(coordinate.chunkCell);
	}

	void setBlock(ushort blockID, Coordinate coordinate)
	{
		Cell cell = coordinate.sectorCell;
		// FIXME: handle unloaded chunks
		chunks[cell].setBlock(blockID, coordinate.chunkCell);
	}

	void generate()
	{
		foreach(ubyte x; 0..size) foreach(ubyte y; 0..size) foreach(ubyte z; 0..size)
		{
			// local cell
			Cell cell = Cell(x,y,z);

			Coordinate chunkCoordinate = Coordinate(this, cell);
			Chunk chunk = new Chunk(chunkCoordinate);

			chunk.generate();

			chunks[cell] = chunk;
		}
	}

	/// construct a Sector with its low corner at `coordinate`
	this(Coordinate coordinate)
	{
		this.coordinate = coordinate;
	}
}

