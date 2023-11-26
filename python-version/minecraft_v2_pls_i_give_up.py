import math,keyboard,os
from random import random
from PIL import Image, ImageTk
import tkinter as tk

screen_width = 320
screen_height = 320

blockSize = 80
sidePoint = [0,0,0]

A = [-40, 40, 40]
B = [-40, 40, -40]
C = [40, 40, -40]
D = [40, 40, 40]

image_path = r"D:\PYTHON\excel_minecraft\output-onlinepngtools (1).png"
image = Image.open(image_path)
image = image.convert('RGB')

# Get the dimensions of the image
width, height = image.size
print(image.size)
# Initialize an empty list to store pixel data

squares = []

# Loop through the image and save pixel data as a list of lists
"""
# back (X,40,Z)
for y in range(int(80/10)):
    row = []
    for x in range(int(80/10)):   
        
        pixel = image.getpixel((x*10+5, 90+y*10+5))
        row.append(pixel)
        squares.append([
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)   ,40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize) ,40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) ,40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) ,40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
            pixel
        ])


# left (-40,Y,Z)

for y in range(int(80/10)):
    row = []
    for x in range(int(80/10)):   
        pixel = image.getpixel((x*10+5, 90+y*10+5))
        row.append(pixel)
        squares.append([
            [-40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)   ,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
            [-40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
            [-40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
            [-40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
            pixel
        ])



# right (-40,Y,Z)

for y in range(int(80/10)):
    row = []
    for x in range(int(80/10)):   
        pixel = image.getpixel((x*10+5, 90+y*10+5))
        row.append(pixel)
        squares.append([
            [40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)   ,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
            [40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
            [40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
            [40, sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
            pixel
        ])




# down (X,Y,-40)

for y in range(int(80/10)):
    row = []
    for x in range(int(80/10)):   
        pixel = image.getpixel((x*10+5, 0 +y*10+5))
        row.append(pixel)
        squares.append([
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)   ,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10)),-40],
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize),-40],
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize),-40],
            [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) , sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10)),-40],
            pixel
        ])


"""

# front (X,-40,Z)

for y in range(int(80/10)):
    row = []
    for x in range(int(80/10)):  
        #if x == 0 and y == 0: 
            pixel = image.getpixel((x*10+5, 90+y*10+5))
            row.append(pixel)
            squares.append([
                
                [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) ,-40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
                [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)  + (blockSize / int(80/10)) ,-40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
                [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize)   ,-40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize) + (blockSize / int(80/10))],
                [sidePoint[0] - (blockSize/2) + (x / int(80/10) * blockSize) ,-40,  sidePoint[2] - (blockSize/2) + (y / int(80/10) * blockSize)],
                pixel
            ])




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






def calculate():
    for square in squares:
        transformed_square = []
        for point in square[:4]:
            # Rotate around the y-axis (yaw)
            rotated_x = (point[0] - player_x) * math.cos(math.radians(yaw)) - (point[2] - player_z) * math.sin(math.radians(yaw)) + player_x
            rotated_z = (point[0] - player_x) * math.sin(math.radians(yaw)) + (point[2] - player_z) * math.cos(math.radians(yaw)) + player_z
            # Rotate around the x-axis (pitch)
            rotated_y = (point[1] - player_y) * math.cos(math.radians(pitch)) - (rotated_z - player_z) * math.sin(math.radians(pitch)) + player_y
            transformed_square.append((rotated_x, rotated_y, rotated_z))
        
        draw_square(transformed_square, square[4])

# Function to draw a square on the screen
def draw_square(square, color):
    # Calculate 2D screen coordinates
    screen_coords = []
    for point in square:
        # Perspective projection
        if point[2] <= 0 or point[2] > fov:
            return  # Skip squares behind the player or out of FOV
        screen_x = int((point[0] / point[2]) * fov + 160)  # 320x320 screen, center at (160, 160)
        screen_y = int((point[1] / point[2]) * fov + 160)
        screen_coords.append((screen_x, screen_y))

    # Find bounding box
    min_x = min(coord[0] for coord in screen_coords)
    min_y = min(coord[1] for coord in screen_coords)
    max_x = max(coord[0] for coord in screen_coords)
    max_y = max(coord[1] for coord in screen_coords)

    # Fill the square within the bounding box
    for x in range(min_x, max_x + 1):
        for y in range(min_y, max_y + 1):
            if is_point_inside_square(x, y, screen_coords):
                draw_points(x, y, color)

# Function to check if a point is inside a convex polygon (square in this case)
def is_point_inside_square(x, y, square):
    # Check using the winding number algorithm
    winding_number = 0
    for i in range(4):
        x1, y1 = square[i]
        x2, y2 = square[(i + 1) % 4]
        if y1 <= y:
            if y2 > y and is_left(x1, y1, x2, y2, x, y):
                winding_number += 1
        elif y2 <= y and is_left(x1, y1, x2, y2, x, y):
            winding_number -= 1
    return winding_number != 0

# Function to check if a point is to the left of a line
def is_left(x1, y1, x2, y2, x, y):
    return (x2 - x1) * (y - y1) - (x - x1) * (y2 - y1) > 0






























def update_image():
    global image,photo,canvas
    photo = ImageTk.PhotoImage(image)
    canvas.create_image(0, 0, image=photo, anchor=tk.NW)
    

while True:
    s = input()
    for a in s:
        if a == "w":
            player_x += int(-5 * math.sin(math.radians(yaw)) ) # Update x based on yaw
            player_z += int(5 * math.cos(math.radians(yaw))  ) # Update y based on yaw
        elif a == "s":
            player_x += int(5 * math.sin(math.radians(yaw))  ) # Update x based on yaw
            player_z += int(-5 * math.cos(math.radians(yaw)))  # Update y based on yaw
        elif a == "a":
            player_x -= int(5 * math.cos(math.radians(yaw)) )  # Move left in player's perspective
            player_z -= int(5 * math.sin(math.radians(yaw)) )  # Move left in player's perspective
        elif a == "d":
            player_x += int(5 * math.cos(math.radians(yaw)) )  # Move right in player's perspective
            player_z += int(5 * math.sin(math.radians(yaw)) )  # Move right in player's perspective
        elif a == "q":
            yaw += 5
        elif a == "e":
            yaw -= 5
        elif a == "r":
            pitch += 5
            if pitch > 90:
                pitch = 90
        elif a == "f":
            pitch -= 5
            if pitch < -90:
                pitch = -90
        elif a == "+":
            fov += 5
        elif a == "-":
            fov -= 5
        elif a == " ":
            player_y -= 5
        elif a == "x":
            player_y += 5


    clear_screen()
    calculate()
    update_image()
    output_path = 'D:\\PYTHON\\excel_minecraft\\output.png'
    image.save(output_path)
    print(player_x,player_y,player_z,pitch,yaw)

    # Open the saved image (optional)

t.screen.mainloop()





