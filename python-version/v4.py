import math,keyboard,os
from random import random
from PIL import Image, ImageTk
import tkinter as tk

screen_width = 320
screen_height = 320

A = [-40, 40, 40, 0]
B = [-40, 40, -40, 0]
C = [40, 40, -40, 0]
D = [40, 40, 40, 0]

# Player's position and orientation
player_x = 0  # You can adjust the player's position as needed
player_y = -250
player_z = 0
yaw = 0  # Adjust as needed (0 is front, 90 is left)
pitch = 0  # Adjust as needed (0 is neutral, positive angles tilt up)
fov = 90

root = tk.Tk()
root.title("Image Viewer")

canvas = tk.Canvas(root, width=screen_width, height=screen_height)
canvas.pack()

def rgb_to_turtle_color(rgb_tuple):
    return "#{:02x}{:02x}{:02x}".format(rgb_tuple[0], rgb_tuple[1], rgb_tuple[2])


colors = [
    [(255,0,0)],
    [(0,255,0)],
    [(0,0,255)],
    [(255,255,255)],
]

for i in range(4):
    for c in range(1,4):
        colors[i].append((int(colors[i][0][0] * ((4 - c) / 4)), int(colors[i][0][1] * ((4 - c) / 4)), int(colors[i][0][2] * ((4 - c) / 4))))

print(colors)

def clear_screen():
    global image
    image =  Image.new('RGB', (screen_width, screen_height), 'yellow') 


image = Image.new('RGB', (screen_width, screen_height), 'yellow') 
photo = ImageTk.PhotoImage(image)
canvas.create_image(0, 0, image=photo, anchor=tk.NW)


def draw_points(x,y,c):
    global image
    if 0 <= x < screen_width and 0 <= y < screen_height:
        image.putpixel((x, y), c)


# Define the 3D cube's coordinates
cube = [
    (20, 20, 20),
    (-20, 20, 20),
    (20, -20, 20),
    (20, 20, -20),
    (-20, -20, 20),
    (-20, 20, -20),
    (20, -20, -20),
    (-20, -20, -20),
]

cube2 = [
    (40, 40, 40),
    (-40, 40, 40),
    (40, -40, 40),
    (40, 40, -40),
    (-40, -40, 40),
    (-40, 40, -40),
    (40, -40, -40),
    (-40, -40, -40),
]

cubesSizes = 40

cubes = [
    {
    "center": [],
    "radius": cubesSizes,
    "type": "grass_block",
    "sides":[] 
    }
]
allSides = []


colors = {"grass_block":[]}

image_path = r"D:\PYTHON\excel_minecraft\output-onlinepngtools (1).png"
image = Image.open(image_path)

# Get the dimensions of the image
width, height = image.size
print(image.size)
# Initialize an empty list to store pixel data


# Loop through the image and save pixel data as a list of lists
for y in range(int(height/10)):
    row = []
    for x in range(int(width/10)):
        pixel = image.getpixel((x*10+5, y*10+5))
        row.append(pixel)
        print(pixel)
    colors["grass_block"].append(row)



def get_line_pixels(start, end, pixels_by_y):
    x0, y0 = start
    x1, y1 = end
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    sx = -1 if x0 > x1 else 1
    sy = -1 if y0 > y1 else 1
    err = dx - dy

    while x0 != x1 or y0 != y1:
        draw_points(x0, y0,(0,0,0))
        if y0 not in pixels_by_y:
            pixels_by_y[y0] = set()
        pixels_by_y[y0].add(x0)
        e2 = 2 * err
        if e2 > -dy:
            err -= dy
            x0 += sx
        if e2 < dx:
            err += dx
            y0 += sy

def calculate():
    pixels_by_y = {}
    allpixels = []
    yaw_rad = math.radians(yaw)
    pitch_rad = math.radians(pitch)
    rotation_matrix = [
        [math.cos(yaw_rad), -math.sin(yaw_rad)],
        [math.sin(yaw_rad), math.cos(yaw_rad)]
    ]

    square_vertices_2d = []

    # Apply the rotation and perspective projection to the square's vertices
    for point in [A, B, C, D]:
        # Translate the square's position relative to the player's position
        translated_vertex = (
            point[0] - player_x,
            point[1] - player_y,
            point[2] - player_z
        )

        # Apply pitch rotation (tilting)
        rotated_vertex = (
            translated_vertex[0],
            translated_vertex[1] * math.cos(pitch_rad) - translated_vertex[2] * math.sin(pitch_rad),
            translated_vertex[1] * math.sin(pitch_rad) + translated_vertex[2] * math.cos(pitch_rad)
        )

        # Apply yaw rotation
        rotated_x = rotated_vertex[0] * rotation_matrix[0][0] + rotated_vertex[1] * rotation_matrix[1][0]
        rotated_y = rotated_vertex[0] * rotation_matrix[0][1] + rotated_vertex[1] * rotation_matrix[1][1]

        # Perspective projection
        if rotated_y != 0:
            projected_x = rotated_x / rotated_y
            projected_y = rotated_vertex[2] / rotated_y
        else:
            projected_x = float('inf')
            projected_y = float('inf')

        # Map the projected coordinates to the screen space
        screen_x = int((projected_x + 1) * 0.5 * screen_width)
        screen_y = int((1 - projected_y) * 0.5 * screen_height)

        # Store the 2D coordinates in the dictionary
        square_vertices_2d.append((screen_x,screen_y))

    print(square_vertices_2d,"*")






    for i in square_vertices_2d:
        draw_points(i[0],i[1],(0,0,0))

    for i in range(4):
        start_point = square_vertices_2d[i]
        end_point = square_vertices_2d[(i + 1) % 4]
        get_line_pixels(start_point, end_point, pixels_by_y)


    min_x = min([point[0] for point in square_vertices_2d])
    max_x = max([point[0] for point in square_vertices_2d])
    min_y = min([point[1] for point in square_vertices_2d])
    max_y = max([point[1] for point in square_vertices_2d])

    for y in range(min_y, max_y + 1):
        if y in pixels_by_y:
            for x in range(min(pixels_by_y[y]), max(pixels_by_y[y]) + 1):
                allpixels.append((x, y))
                draw_points(x,y,(0,0,0))

























def update_image():
    global image,photo,canvas
    photo = ImageTk.PhotoImage(image)
    canvas.create_image(0, 0, image=photo, anchor=tk.NW)
    

while True:
    s = input()
    for a in s:
        if a == "w":
            player_y+=5
        elif a == "s":
            player_y-=5
        elif a == "a":
            player_x-=5
        elif a == "d":
            player_x+=5
        elif a == "q":
            yaw+=5
        elif a == "e":
            yaw-=5
        elif a == "r":
            pitch+=5
        elif a == "f":
            pitch-=5
        elif a == "+":
            fov+=5
        elif a == "-":
            fov-=5
        elif a == " ":
            player_z-=5
        elif a == "x":
            player_z+=5
    clear_screen()
    calculate()
    update_image()
    output_path = 'D:\\PYTHON\\excel_minecraft\\output.png'
    image.save(output_path)

    # Open the saved image (optional)

t.screen.mainloop()





