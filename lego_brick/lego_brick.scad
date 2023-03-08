$fn=20;

// Configurable
stud_text = "LEGO";
x_size = 3;
y_size = 2;
value = 10;
assert(x_size >= 1);
assert(y_size >= 1);

// Constants
pitch = 8.0;
padding = -0.2;
hollow_padding = -3.1;
brick_height = 9.60;
inner_brick_height = brick_height - 1.0;
stud_height = 1.80;
stud_offset = 3.90;
stud_radius = 2.42;

difference() {
    cube([x_size*pitch + padding,y_size*pitch + padding,brick_height]);
    translate([1.45,1.45])
        cube([x_size*pitch+hollow_padding,y_size*pitch+hollow_padding,inner_brick_height]);
}

translate([stud_offset,stud_offset])
for (i = [0:x_size-1]) {
    for (j = [0:y_size-1]) {
        translate([i*pitch,j*pitch,brick_height]){
            cylinder(h=stud_height,r=stud_radius);
            translate([0,0,1.8])
            linear_extrude(0.15)
                text(stud_text, 0.9, halign="center", valign="center", font="Liberation Sans:style=Bold Italic");
        }
    }
}

translate([7.90,7.90])
if (x_size >= 2 && y_size >= 2)
for (i = [0:x_size-2]) {
    for ( j = [0:y_size-2] ) {
        translate([i*pitch,j*pitch])
        difference() {
            cylinder(h=inner_brick_height,r=3.25);
            cylinder(h=inner_brick_height,r=2.40);
        }
    }
}