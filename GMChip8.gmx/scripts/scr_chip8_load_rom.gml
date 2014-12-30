///scr_chip8_load_rom(file);

//Find and open the ROM in read only mode
var file_name = argument[0];
var file_rom  = file_bin_open(working_directory + file_name, 0);

//Create a buffer to store the ROM data in
buffer_rom = buffer_create(3584, buffer_fast, 1);

//Read data from the file into the buffer
for (var i = 0; i < file_bin_size(file_rom); i ++)
{
    file_bin_seek(file_rom, i);
    var data = file_bin_read_byte(file_rom);
    buffer_write(buffer_rom, buffer_u8, data);
}

file_bin_close(file_rom);

//Copy data from the ROM buffer into the memory starting at 0x200
var buffer_size = buffer_tell(buffer_rom);

if ((4096 - 512) > buffer_size)
{
    for (var i = 0; i < buffer_size; i ++)
    {
        buffer_seek(buffer_rom, buffer_seek_start, i);
        memory[i + 512] = buffer_read(buffer_rom, buffer_u8);
    }
}
else
{
    show_debug_message("ERROR: ROM TOO BIG FOR MEMORY");
}

//Dump the content of the memory
/*
file_romDump = file_text_open_write(working_directory + "memdump.txt");

for (var i = 0; i < 4096; i ++)
{
    file_text_write_real(file_romDump, memory[i]);
    file_text_writeln(file_romDump);
}

file_text_close(file_romDump);
*/