#!/bin/python3

import argparse
import os
import subprocess

# Make sure the script runs from the script's directory
os.chdir(os.path.dirname(os.path.realpath(__file__)))

FILENAME = "lego_brick.scad"

parser = argparse.ArgumentParser(
    prog="Lego Brick Generator",
    description="Generates a Lego brick defined in lego_brick.scad",
)
parser.add_argument("-x", "--length", type=int, dest="x_size")
parser.add_argument("-y", "--width", type=int, dest="y_size")
parser.add_argument("-f", "--n_fragments", type=int, dest="$fn")


def parse_openscad_variables(**arguments):
    arg_list = []
    for arg_name, value in arguments.items():
        if value:
            arg_list.append(f"{arg_name}={value}")
    return "{}".format(";".join(arg_list)) if arg_list else ""


def generate(filename=FILENAME, **arguments):
    openscad_variables = parse_openscad_variables(**arguments)
    print(f"Generating with args: {openscad_variables}")
    subprocess.run(["openscad", "-D", openscad_variables, "-o", "out.png", filename])


def _main():
    args = parser.parse_args()
    generate(**vars(args))


if __name__ == "__main__":
    _main()
