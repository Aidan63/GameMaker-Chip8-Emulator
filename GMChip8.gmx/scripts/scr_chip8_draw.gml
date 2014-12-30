///scr_chip8_draw()

if (drawFlag)
{
    for (var yy = 0; yy < 32; yy ++)
    {
        for (var xx = 0; xx < 64; xx ++)
        {
            if (gfx[(yy * 64) + xx] == 0)
            {
                draw_set_colour(c_black);
            }
            else
            {
                draw_set_colour(c_white);
            }
            
            draw_point(xx, yy);
        }
    }
}