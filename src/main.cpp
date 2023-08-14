
// System includes
#include <iostream>
#include <chrono>
#include <fstream>

#ifdef ENABLE_FILESYSTEM
#include <filesystem>
#endif

// -------------------------------------------------------------------------
// ENTRY
// -------------------------------------------------------------------------
int main( int argc, const char *argv[] )
{
	if ( argc == 1 )
		return 1;

	char action = argv[ 1 ][ 0 ];
	const char *filename = ( argc == 3 ? argv[ 2 ] : "TEMP/build_time_data.bin" );

	if ( action == 's' || action == 'S' )
	{
		std::chrono::high_resolution_clock::duration::rep start = std::chrono::high_resolution_clock::now().time_since_epoch().count();

		#ifdef ENABLE_FILESYSTEM
		std::filesystem::create_directories( std::filesystem::path( filename ).remove_filename() );
		#endif

		std::ofstream file( filename );
		if ( !file.is_open() )
			return 2;
		file << start;
		file.close();
	}
	else if ( action == 'e' || action == 'E' )
	{
		std::ifstream file( filename );
		if ( !file.is_open() )
			return 3;
		std::chrono::high_resolution_clock::duration::rep startTime;
		file >> startTime;
		file.close();
		std::chrono::high_resolution_clock::duration start( startTime );

		std::chrono::microseconds elapsed = std::chrono::duration_cast<std::chrono::microseconds>( std::chrono::high_resolution_clock::now().time_since_epoch() - start );
		std::cout << "Elapsed time: " << elapsed.count() << " microseconds (" << static_cast<float>( elapsed.count() ) / 1000000 << " seconds)" << std::endl;
	}

	return 0;
}