///scr_chip8_init();

//Declare the font set
//0
chip8_fontSet[0 ] = $F0;
chip8_fontSet[1 ] = $90;
chip8_fontSet[2 ] = $90;
chip8_fontSet[3 ] = $90;
chip8_fontSet[4 ] = $F0;
//1
chip8_fontSet[5 ] = $20;
chip8_fontSet[6 ] = $60;
chip8_fontSet[7 ] = $20;
chip8_fontSet[8 ] = $20;
chip8_fontSet[9 ] = $70;
//2
chip8_fontSet[10] = $F0;
chip8_fontSet[11] = $10;
chip8_fontSet[12] = $F0;
chip8_fontSet[13] = $80;
chip8_fontSet[14] = $F0;
//3
chip8_fontSet[15] = $F0;
chip8_fontSet[16] = $10;
chip8_fontSet[17] = $F0;
chip8_fontSet[18] = $10;
chip8_fontSet[19] = $F0;
//4
chip8_fontSet[20] = $90;
chip8_fontSet[21] = $90;
chip8_fontSet[22] = $F0;
chip8_fontSet[23] = $10;
chip8_fontSet[24] = $10;
//5
chip8_fontSet[25] = $F0;
chip8_fontSet[26] = $80;
chip8_fontSet[27] = $F0;
chip8_fontSet[28] = $10;
chip8_fontSet[29] = $F0;
//6
chip8_fontSet[30] = $F0;
chip8_fontSet[31] = $80;
chip8_fontSet[32] = $F0;
chip8_fontSet[33] = $90;
chip8_fontSet[34] = $F0;
//7
chip8_fontSet[35] = $F0;
chip8_fontSet[36] = $10;
chip8_fontSet[37] = $20;
chip8_fontSet[38] = $40;
chip8_fontSet[39] = $40;
//8
chip8_fontSet[40] = $F0;
chip8_fontSet[41] = $90;
chip8_fontSet[42] = $F0;
chip8_fontSet[43] = $90;
chip8_fontSet[44] = $F0;
//9
chip8_fontSet[45] = $F0;
chip8_fontSet[46] = $90;
chip8_fontSet[47] = $F0;
chip8_fontSet[48] = $10;
chip8_fontSet[49] = $F0;
//A
chip8_fontSet[50] = $F0;
chip8_fontSet[51] = $90;
chip8_fontSet[52] = $F0;
chip8_fontSet[53] = $90;
chip8_fontSet[54] = $90;
//B
chip8_fontSet[55] = $E0;
chip8_fontSet[56] = $90;
chip8_fontSet[57] = $E0;
chip8_fontSet[58] = $90;
chip8_fontSet[59] = $E0;
//C
chip8_fontSet[60] = $F0;
chip8_fontSet[61] = $80;
chip8_fontSet[62] = $80;
chip8_fontSet[63] = $80;
chip8_fontSet[64] = $F0;
//D
chip8_fontSet[65] = $E0;
chip8_fontSet[66] = $90;
chip8_fontSet[67] = $90;
chip8_fontSet[68] = $90;
chip8_fontSet[69] = $E0;
//E
chip8_fontSet[70] = $F0;
chip8_fontSet[71] = $80;
chip8_fontSet[72] = $F0;
chip8_fontSet[73] = $80;
chip8_fontSet[74] = $F0;
//F
chip8_fontSet[75] = $F0;
chip8_fontSet[76] = $80;
chip8_fontSet[77] = $F0;
chip8_fontSet[78] = $80;
chip8_fontSet[79] = $80;

//Initilise the program counter, opcode, index register and the stack pointer
//programs start at address $200 (512)
pc     = $200;
opcode = 0;
I      = 0;
sp     = 0;

//initilise the display
for (var i = 0; i < 2048; i ++)
{
    gfx[i] = 0;
}

//initilise the 16 level stack
for (var i = 0; i < 16; i ++)
{
    stack[i] = 0;
}

//initilise V-regs V0-Vf
for (var i = 0; i < 16; i ++)
{
    V[i] = 0;
}

//Initilise the keys
for (var i = 0; i < 16; i ++)
{
    key[i] = V[i];
}

//Initilise the memory
for (var i = 0; i < 4096; i ++)
{
    memory[i] = 0;
}

//Load in the font set
for (var i = 0; i < 80; i ++)
{
    memory[i] = chip8_fontSet[i];
}

//Reset the delay and sound timer
delay_timer = 0;
sound_timer = 0;

//Set the screen for drawing
drawFlag = true;

