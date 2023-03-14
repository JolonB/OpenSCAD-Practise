cube_size = 45;
cube_wall_thickness = 3;

assert(cube_size > 2 * cube_wall_thickness);

difference() {
    cube(cube_size);
    let (inner_cube_size = cube_size - 2*cube_wall_thickness) {
        translate([cube_wall_thickness, cube_wall_thickness,cube_wall_thickness])
        cube([inner_cube_size, inner_cube_size, cube_size - cube_wall_thickness]);
    }
}