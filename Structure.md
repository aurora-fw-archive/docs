# Module Structure and Hierarchy

## UNIX-based
- `out`: Output Files
	- `bin`: Output Binaries and Executables
		- `$arch$`: Architecture specific files
	- `lib/lib32/lib64`: Output Libraries
		- `$arch$`: Architecture specific files
	- `share`: Output Shared Data
	- `etc`: Output configurations
	- `tmp`: Temporary Files
		- `obj` - Output Objects (Compiler)

## Other Systems

- `Output`
	- `Binaries`
	- `Libraries`
	- `Shares`
	- `Temporary`
		- `Objects`