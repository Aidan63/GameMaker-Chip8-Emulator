///scr_chip8_cycle();

//fetch opcode
opcode = memory[pc] << 8 | memory[pc + 1];

//decode and exxecute
// Process opcode
switch(opcode & $F000)
{
    case $0000:
        switch (opcode & $000F)
        {
            // $00E0: Clears the screen
            case $0000:
                for (var i = 0; i < 2048; ++i)
                {
                    gfx[i] = $0;
                }
                drawFlag = true;
                pc += 2;
            break;
            
            // $00EE: Returns from subroutine
            case $000E:
                sp --;
                pc = stack[sp];
                pc += 2;
            break;
            
            default:
                show_debug_message ("Unknown opcode [$0000]: $" + string(opcode));
            break;
        }
    break;
    
    // $1NNN: Jumps to address NNN
    case $1000:
        pc = opcode & $0FFF;
    break;
    
    // $2NNN: Calls subroutine at NNN.
    case $2000:
        stack[sp] = pc;
        sp ++;
        pc = opcode & $0FFF;
    break;
    
    // $3XNN: Skips the next instruction if VX equals NN
    case $3000:
        if(V[(opcode & $0F00) >> 8] == (opcode & $00FF))
        {
            pc += 4;
        }
        else
        {
            pc += 2;
        }
    break;
    
    // $4XNN: Skips the next instruction if VX doesn't equal NN
    case $4000:
        if(V[(opcode & $0F00) >> 8] != (opcode & $00FF))
        {
            pc += 4;
        }
        else
        {
            pc += 2;
        }
    break;
    
    // $5XY0: Skips the next instruction if VX equals VY.
    case $5000:
        if(V[(opcode & $0F00) >> 8] == V[(opcode & $00F0) >> 4])
        {
            pc += 4;
        }
        else
        {
            pc += 2;
        }
    break;
    
    // $6XNN: Sets VX to NN.
    case $6000:
        V[(opcode & $0F00) >> 8] = opcode & $00FF;
        pc += 2;
    break;
    
    // $7XNN: Adds NN to VX.
    case $7000:
        V[(opcode & $0F00) >> 8] += opcode & $00FF;
        pc += 2;
    break;
    
    case $8000:
        switch (opcode & $000F)
        {
            case $0000: // $8XY0: Sets VX to the value of VY
                V[(opcode & $0F00) >> 8] = V[(opcode & $00F0) >> 4];
                pc += 2;
            break;
            
            case $0001: // $8XY1: Sets VX to "VX OR VY"
                V[(opcode & $0F00) >> 8] |= V[(opcode & $00F0) >> 4];
                pc += 2;
            break;
            
            case $0002: // $8XY2: Sets VX to "VX AND VY"
                V[(opcode & $0F00) >> 8] &= V[(opcode & $00F0) >> 4];
                pc += 2;
            break;
            
            case $0003: // $8XY3: Sets VX to "VX XOR VY"
                V[(opcode & $0F00) >> 8] ^= V[(opcode & $00F0) >> 4];
                pc += 2;
            break;
            
            case $0004: // $8XY4: Adds VY to VX. VF is set to 1 when there's a carry, and to 0 when there isn't
                if (V[(opcode & $00F0) >> 4] > ($FF - V[(opcode & $0F00) >> 8])) 
                {
                    V[$F] = 1; //carry
                }
                else
                {
                    V[$F] = 0;
                }
                
                V[(opcode & $0F00) >> 8] += V[(opcode & $00F0) >> 4];
                pc += 2;
            break;
            
            case $0005: // $8XY5: VY is subtracted from VX. VF is set to 0 when there's a borrow, and 1 when there isn't
                if (V[(opcode & $00F0) >> 4] > V[(opcode & $0F00) >> 8])
                {
                    V[$F] = 0;
                }
                else
                { 
                    V[$F] = 1;
                }
                
                V[(opcode & $0F00) >> 8] -= V[(opcode & $00F0) >> 4];
                pc += 2;
            break;
            
            case $0006: // $8XY6: Shifts VX right by one. VF is set to the value of the least significant bit of VX before the shift
                V[$F] = V[(opcode & $0F00) >> 8] & $1;
                V[(opcode & $0F00) >> 8] = V[(opcode & $0F00) >> 8] >> 1;
                pc += 2;
            break;
            
            case $0007: // $8XY7: Sets VX to VY minus VX. VF is set to 0 when there's a borrow, and 1 when there isn't
                if(V[(opcode & $0F00) >> 8] > V[(opcode & $00F0) >> 4])
                {
                    V[$F] = 0;
                }
                else
                {
                    V[$F] = 1;
                }
                
                V[(opcode & $0F00) >> 8] = V[(opcode & $00F0) >> 4] - V[(opcode & $0F00) >> 8];
                pc += 2;
            break;
            
            case $000E: // $8XYE: Shifts VX left by one. VF is set to the value of the most significant bit of VX before the shift
                V[$F] = V[(opcode & $0F00) >> 8] >> 7;
                V[(opcode & $0F00) >> 8] = V[(opcode & $0F00) >> 8] << 1;
                pc += 2;
            break;
            
            default:
                show_debug_message ("Unknown opcode [$8000]:" + string(opcode));
            break;
        }
    break;
    
    case $9000: // $9XY0: Skips the next instruction if VX doesn't equal VY
        if (V[(opcode & $0F00) >> 8] != V[(opcode & $00F0) >> 4])
        {
            pc += 4;
        }
        else
        {
            pc += 2;
        }
    break;
    
    case $A000: // ANNN: Sets I to the address NNN
        I = opcode & $0FFF;
        pc += 2;
    break;
    
    case $B000: // BNNN: Jumps to the address NNN plus V0
        pc = (opcode & $0FFF) + V[0];
    break;
    
    case $C000: // CXNN: Sets VX to a random number and NN
        V[(opcode & $0F00) >> 8] = (irandom($FF)) & (opcode & $00FF);
        pc += 2;
    break;
    
    case $D000: // DXYN: Draws a sprite at coordinate (VX, VY) that has a width of 8 pixels and a height of N pixels. 
    {
        var xx     = V[(opcode & $0F00) >> 8];
        var yy     = V[(opcode & $00F0) >> 4];
        var height = opcode & $000F;
        var pixel;
        
        V[$F] = 0;
        
        for (var yline = 0; yline < height; yline++)
        {
            pixel = memory[I + yline];
            for (var xline = 0; xline < 8; xline++)
            {
                if ((pixel & ($80 >> xline)) != 0)
                {
                    if(gfx[(xx + xline + ((yy + yline) * 64))] == 1)
                    {
                        V[$F] = 1;                                    
                    }
                    
                    gfx[xx + xline + ((yy + yline) * 64)] ^= 1;
                }
            }
        }
        
        drawFlag = true;
        pc += 2;
    }
    break;
    
    case $E000:
        switch (opcode & $00FF)
        {
            case $009E: // EX9E: Skips the next instruction if the key stored in VX is pressed
                if (key[V[(opcode & $0F00) >> 8]] != 0)
                {
                    pc += 4;
                }
                else
                {
                    pc += 2;
                }
            break;
            
            case $00A1: // EXA1: Skips the next instruction if the key stored in VX isn't pressed
                if (key[V[(opcode & $0F00) >> 8]] == 0)
                {
                    pc += 4;
                }
                else
                {
                    pc += 2;
                }
            break;
            
            default:
                show_debug_message ("Unknown opcode [$E000]:" + string(opcode));
            break;
        }
    break;
    
    case $F000:
        switch (opcode & $00FF)
        {
            case $0007: // FX07: Sets VX to the value of the delay timer
                V[(opcode & $0F00) >> 8] = delay_timer;
                pc += 2;
            break;
            
            case $000A: // FX0A: A key press is awaited, and then stored in VX
            {
                var keyPress = false;
                
                for (var i = 0; i < 16; ++i)
                {
                    if (key[i] != 0)
                    {
                        V[(opcode & $0F00) >> 8] = i;
                        keyPress = true;
                    }
                }
                
                // If we didn't received a keypress, skip this cycle and try again.
                if (!keyPress)
                {
                    //return;
                }
                
                pc += 2;
            }
            break;
            
            case $0015: // FX15: Sets the delay timer to VX
                delay_timer = V[(opcode & $0F00) >> 8];
                pc += 2;
            break;
            
            case $0018: // FX18: Sets the sound timer to VX
                sound_timer = V[(opcode & $0F00) >> 8];
                pc += 2;
            break;
            
            case $001E: // FX1E: Adds VX to I
                if (I + V[(opcode & $0F00) >> 8] > $FFF)
                {
                    V[$F] = 1;
                }
                else
                {
                    V[$F] = 0;
                }
                
                I += V[(opcode & $0F00) >> 8];
                pc += 2;
            break;
            
            case $0029: // FX29: Sets I to the location of the sprite for the character in VX. Characters 0-F (in hexadecimal) are represented by a 4x5 font
                I = V[(opcode & $0F00) >> 8] * $5;
                pc += 2;
            break;
            
            case $0033: // FX33: Stores the Binary-coded decimal representation of VX at the addresses I, I plus 1, and I plus 2
                memory[I]     = V[(opcode & $0F00) >> 8] / 100;
                memory[I + 1] = (V[(opcode & $0F00) >> 8] / 10) % 10;
                memory[I + 2] = (V[(opcode & $0F00) >> 8] % 100) % 10;
                pc += 2;
            break;
            
            case $0055: // FX55: Stores V0 to VX in memory starting at address I
                for (var i = 0; i <= ((opcode & $0F00) >> 8); ++i)
                {
                    memory[I + i] = V[i];
                }
                
                I += ((opcode & $0F00) >> 8) + 1;
                pc += 2;
            break;
            
            case $0065: // FX65: Fills V0 to VX with values from memory starting at address I
                for (var i = 0; i <= ((opcode & $0F00) >> 8); ++i)
                {
                    V[i] = memory[I + i];
                }
                
                I += ((opcode & $0F00) >> 8) + 1;
                pc += 2;
            break;
            
            default:
                show_debug_message ("Unknown opcode [$F000]:" + string(opcode));
            break;
        }
    break;
    
    default:
    show_debug_message ("Unknown opcode: $%X\n");
}

if (delay_timer > 0)
{
    delay_timer --;
}

if (sound_timer > 0)
{
    if (sound_timer == 1)
    {
        show_debug_message("BEEP");
        audio_play_sound(snd_chip8_beep, 0, false);
    }
    
    sound_timer --;
}