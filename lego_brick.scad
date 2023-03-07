$fn=50;

stud_text = [["S","T","U","D"], ["L","E","G","O"]];

difference() {
    cube([31.80,15.80,9.60]);
    translate([1.45,1.45])
        cube([28.90,12.90,8.60]);
}

translate([3.90,3.90])
for (i = [0:3]) {
    for (j = [0:1]) {
        translate([i*8,j*8,9.60]){
            cylinder(h=1.80,r=2.42);
            translate([0,0,1.8])
            linear_extrude(0.4)
                text(stud_text[j][i], 1.6, halign="center", valign="center");
        }
    }
}

translate([7.90,7.90])
for (i = [0:2]) {
    translate([i*8,0])
    difference() {
        cylinder(h=8.60,r=3.25);
        cylinder(h=8.60,r=2.40);
    }
}