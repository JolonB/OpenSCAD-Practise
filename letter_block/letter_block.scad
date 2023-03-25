use <fontmetrics.scad>;

_MIN_MAX_SCALING = 1.2;

TEXT_DEPTH = 0.4;
LETTER_FONT="Liberation Mono:style=Bold";

module letter (character, size, font, depth, center=[0,0,0], rotation=[0,0,0]) {
    char_len = len(character);
    assert(char_len == 1, str("A letter cannot contain more than one character. '", character, "' contains ", char_len));
    character = uppercaseChar(character);

    dimensions = measureTextBounds(character, font=font, size=size)[1];
    scale_factor = size / max(dimensions);

    let (
    size = scale_factor >= _MIN_MAX_SCALING ? size * _MIN_MAX_SCALING : scale_factor < 1 ? size * scale_factor : size,
    char_bounds = measureTextBounds(character, font=font, size=size),
    corner_pos = char_bounds[0],
    dimensions = char_bounds[1]
    ) {
    translate(center)
    rotate(rotation)
    linear_extrude(depth)
    translate(-corner_pos - dimensions/2)
    text(character, font=font, size=size);
    }
}

module border (inner_size, thickness, depth, center=[0,0,0], rotation=[0,0,0]) {
    translate(center)
    rotate(rotation)
    linear_extrude(depth)
    difference() {
        square(inner_size + thickness, center=true);
        square(inner_size, center=true);
    }
}

module hollow_cube (size, wall_thickness) {
    difference() {
        cube(size);
        let (inner_size = size - 2*wall_thickness) {
            translate([wall_thickness, wall_thickness, wall_thickness])
            cube([inner_size, inner_size, size-wall_thickness]);
        }
    }
}


module bordered_letter(character, letter_size, border_thickness, border_padding, depth, font, center=[0,0,0], rotation=[0,0,0]) {
    union() {
        letter(character, letter_size, font=font, depth=depth, center=center, rotation=rotation);
        border(letter_size + 2*border_padding, border_thickness, depth=depth, center=center, rotation=rotation);
    }
}


module letter_cube(
        characters, cube_size, border_margin, border_thickness, border_padding,
        depth=TEXT_DEPTH, font=LETTER_FONT) {
    assert(len(characters) == 4);
    color("white")
    translate([-cube_size/2, -cube_size/2, 0])
    cube(cube_size);

    let (
            outline_size = border_margin + border_padding + border_thickness,
            letter_size = cube_size-2*outline_size,
            letter_centering = cube_size/2
        ) {
            for (i = [0:3]) {
                angle = i * 90;
                x_shift = cos(angle) * letter_centering;
                y_shift = sin(angle) * letter_centering;
                center = [x_shift, y_shift, letter_centering];
                rotation = [0, 90, angle];
                bordered_letter(
                    characters[i], letter_size, border_thickness, border_padding,
                    depth=depth, font=font, center=center, rotation=rotation
                );
            }
    }
}

// TEST //

characters = "ABCD";
cube_size = 45;
text_border_margin = 3;  // outer
text_border_padding = 4; // inner
text_border_thickness = 1.5;

letter_cube(characters, cube_size, text_border_margin, text_border_thickness, text_border_padding);
