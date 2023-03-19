cube_size = 45;
cube_wall_thickness = 3;
text_border_margin = 3;  // outer
text_border_padding = 2; // inner

assert(cube_size > 2 * cube_wall_thickness);

module letter (character, size, center=[0,0,0], rotation=[0,0,0]) {
    char_len = len(character);
    assert(char_len == 1, str("A letter cannot contain more than one character. '", character, "' contains ", char_len));

    translate_shift = text_border_margin + text_border_padding;
    // TODO set to 0,0
    //translate([size/2, 0, size/2])
    translate(center)
    rotate(rotation)
    linear_extrude(0.2)
    translate([-size/2,-size/2])
    text(character, size, font="Lato:style=Bold");
}

module hollow_cube(size, wall_thickness) {
    difference() {
        cube(size);
        let (inner_size = size - 2*wall_thickness) {
            translate([wall_thickness, wall_thickness, wall_thickness])
            cube([inner_size, inner_size, size-wall_thickness]);
        }
    }
}

module letter_cube(size, wall_thickness) {
    translate([-size/2, -size/2, 0])
    hollow_cube(size, wall_thickness);
}


let (
        translate_shift = text_border_margin + text_border_padding,
        letter_size = cube_size-2*translate_shift,
        letter_shift = cube_size/2
    ) {
        echo(letter_size);
    #letter("A", letter_size, center=[0, -letter_shift, letter_shift], rotation=[90, 90, 0]);
    #letter("B", letter_size, center=[letter_shift, 0, letter_shift], rotation=[0,90,0]);
    letter("C", letter_size, center=[0, letter_shift, letter_shift], rotation=[0,90,90]);
    letter("D", letter_size, center=[-letter_shift, 0, letter_shift], rotation=[180,90,0]);
}

letter_cube(cube_size, cube_wall_thickness);
