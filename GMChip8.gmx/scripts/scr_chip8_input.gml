///scr_chip8_input();

//ROW 1
//KEY 1
if (keyboard_check(ord("1")))
{
    key[$1] = 1;
}
else
{
    key[$1] = 0;
}
//KEY 2
if (keyboard_check(ord("2")))
{
    key[$2] = 1;
}
else
{
    key[$2] = 0;
}
//KEY 3
if (keyboard_check(ord("3")))
{
    key[$3] = 1;
}
else
{
    key[$3] = 0;
}
//KEY 4
if (keyboard_check(ord("4")))
{
    key[$C] = 1;
}
else
{
    key[$C] = 0;
}

//ROW 2
//KEY Q
if (keyboard_check(ord("Q")))
{
    key[$4] = 1;
}
else
{
    key[$4] = 0;
}
//KEY W
if (keyboard_check(ord("W")))
{
    key[$5] = 1;
}
else
{
    key[$5] = 0;
}
//KEY E
if (keyboard_check(ord("E")))
{
    key[$6] = 1;
}
else
{
    key[$6] = 0;
}
//KEY R
if (keyboard_check(ord("R")))
{
    key[$D] = 1;
}
else
{
    key[$D] = 0;
}

//ROW 3
//KEY A
if (keyboard_check(ord("A")))
{
    key[$7] = 1;
}
else
{
    key[$7] = 0;
}
//KEY S
if (keyboard_check(ord("S")))
{
    key[$8] = 1;
}
else
{
    key[$8] = 0;
}
//KEY D
if (keyboard_check(ord("D")))
{
    key[$9] = 1;
}
else
{
    key[$9] = 0;
}
//KEY F
if (keyboard_check(ord("F")))
{
    key[$E] = 1;
}
else
{
    key[$E] = 0;
}

//ROW 2
//KEY Z
if (keyboard_check(ord("Z")))
{
    key[$A] = 1;
}
else
{
    key[$A] = 0;
}
//KEY X
if (keyboard_check(ord("X")))
{
    key[$0] = 1;
}
else
{
    key[$0] = 0;
}
//KEY C
if (keyboard_check(ord("C")))
{
    key[$B] = 1;
}
else
{
    key[$B] = 0;
}
//KEY V
if (keyboard_check(ord("V")))
{
    key[$F] = 1;
}
else
{
    key[$F] = 0;
}