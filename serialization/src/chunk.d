module chunk;

import coordinate;
import sector;

class Chunk
{
	/// number of blocks per axis
	enum int size = 16;

	static struct Cell
	{
		ubyte x, y, z;
	}

private:
	ushort[size][size][size] blockIDs;

public:
	/// the block in the low corner of this Chunk
	Coordinate coordinate;

	ushort getBlock(Cell cell) const
	{
		return blockIDs[cell.x][cell.y][cell.z];
	}
	ushort getBlock(Coordinate coordinate) const
	{
		return getBlock(coordinate.chunkCell);
	}

	void setBlock(ushort blockID, Cell cell)
	{
		blockIDs[cell.x][cell.y][cell.z] = blockID;
	}
	void setBlock(ushort blockID, Coordinate coordinate)
	{
		setBlock(blockID, coordinate.chunkCell);
	}

	void generate()
	{
		import std.random;
		import std.algorithm : clamp;

		foreach(x; 0..size) foreach(y; 0..size) foreach(z; 0..size)
		{
			// global y coordinate of this block
			long height = coordinate.y + y;

			float airProbability = clamp((cast(float)height) / (Chunk.size * Sector.size), 0f, 1f);

			// 0 if air, 1 if not
			if(dice(airProbability, 1f-airProbability))
			{
				// pick a random block
				ushort id = cast(ushort)uniform(1, 100);
				blockIDs[x][y][z] = id;
			}
		}
	}

	/// construct a Chunk with its low corner at `coordinate`
	this(Coordinate coordinate)
	{
		this.coordinate = coordinate;
	}
}

