A = [-40,40,40,0]
B = [-40,40,-40,0]
C = [40,40,-40,0]
D = [40,40,40,0]


def calculateNew(a,b,c,d):


    all = [
        [a,b,0],
        [b,c,0],
        [c,d,0],
        [d,a,0],
    ]

    for i in all:
        if i[0][1] < 0:
            i[0][3] +=1 
            i[1][3] +=1 
            i[2] = 1

        if i[1][1] < 0:   
            i[0][3] +=1 
            i[1][3] +=1 
            i[2] = 1

        if i[0][1] < 0 and i[1][1] < 0:
            i[2] = -1
        

    for i in all:
        point = None
        if i[2] == 1:
            if i[0][3] == 3:
                point = i[0]
            elif i[1][3] == 3:
                point = i[1]
            
            vector = [i[0][0]-i[1][0],i[0][1]-i[1][1],i[0][2]-i[1][2]]
        
            t = (-i[0][1])/vector[1] # always has to be <0,1>
            

            x = i[0][0] + vector[0]*t
            y = 0
            z = i[0][2] + vector[2]*t

            point[0] = x
            point[1] = y
            point[2] = z

    for i in [a,b,c,d]:
        if i[3] == 4:
            if i[0] > 0 and i[2] > 0:
                #i[3] = "x+z+" 
                i[0] = 1
                i[2] = 320

            elif i[0] < 0 and i[2] > 0:
                #i[3] = "x-z+" 
                i[0] = 1
                i[2] = 1

            elif i[0] > 0 and i[2] < 0:
                #i[3] = "x+z-" 
                i[0] = 320
                i[2] = 320

            elif i[0] < 0 and i[2] < 0:
                #i[3] = "x-z-" 
                i[0] = 320
                i[2] = 1

    for i in [a,b,c,d]:
        print(i)

    for i in all:
        print(i)



    return a[:3],b[:3],c[:3],d[:3]






















import math,keyboard,os
from random import random
from PIL import Image, ImageTk
import tkinter as tk

screen_width = 320
screen_height = 320



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



# Define the screen size

def calculatePoints(A,B,C,D):
    return
    pixel_dict = {}
    print((min(A[0], B[0], C[0], D[0])))
    for x in range(int(min(A[0], B[0], C[0], D[0])), int(max(A[0], B[0], C[0], D[0])) + 1):
        pixel_dict[x] = []
        
        # Calculate the corresponding Y values for each X value
        for point in [A, B, C, D]:
            x0, y0 = point
            if x == x0:
                pixel_dict[x].append(y0)
            elif x0 < x < x0 + 1:
                y = y0 + (point[1] - y0) / (point[0] - x0) * (x - x0)
                pixel_dict[x].append(y)

        # Print the result
    print(pixel_dict)

    for x,y_list in pixel_dict.items():
        for y in y_list():
            draw_points(x,y)



def calculate():
    # Initialize a list to store the 2D coordinates of the cube's vertices
    cube_vertices_2d = []

    # Calculate the player's rotation in radians
    yaw_rad = math.radians(yaw)
    pitch_rad = math.radians(pitch)

    # Calculate the transformation matrix for rotation
    rotation_matrix = [
        [math.cos(yaw_rad), -math.sin(yaw_rad)],
        [math.sin(yaw_rad), math.cos(yaw_rad)]
    ]

    half_fov_rad = math.radians(fov / 2)
    d = 1 / math.tan(half_fov_rad)

    # Apply the rotation to the cube's vertices
    rotated_vertex = []
    for vertex in [A,B,C,D]:
        # Translate the cube's position relative to the player's position
        translated_vertex = (
            vertex[0] - player_x,
            vertex[1] - player_y,
            vertex[2] - player_z,
            
        )



        # Apply pitch rotation (tilting)
        rotated_vertex.append([
            translated_vertex[0],
            translated_vertex[1] * math.cos(pitch_rad) - translated_vertex[2] * math.sin(pitch_rad),
            translated_vertex[1] * math.sin(pitch_rad) + translated_vertex[2] * math.cos(pitch_rad),
            0 # par number of how many times is behind (when 4 then triangle)
        ])

    rotated_vertex[0],rotated_vertex[1],rotated_vertex[2],rotated_vertex[3] = calculateNew(rotated_vertex[0],rotated_vertex[1],rotated_vertex[2],rotated_vertex[3])

    for r_vertex in rotated_vertex:
        print(r_vertex,"X")
        # Apply yaw rotation
        rotated_x = r_vertex[0] * rotation_matrix[0][0] + r_vertex[1] * rotation_matrix[1][0]
        rotated_y = r_vertex[0] * rotation_matrix[0][1] + r_vertex[1] * rotation_matrix[1][1]

        # Perspective projection
        if rotated_y != 0:
            projected_x = rotated_x / rotated_y
            projected_y = r_vertex[2] / rotated_y
        else:
            projected_x = float('inf')
            projected_y = float('inf')

            projected_x = rotated_x / 1 #? my code
            projected_y = r_vertex[2] / 1 #? my code
            #continue

        # Apply the perspective projection matrix
        projected_x *= d
        projected_y *= d

        # Map the projected coordinates to the screen space
        screen_x = int((projected_x + 1) * 0.5 * screen_width)
        screen_y = int((1 - projected_y) * 0.5 * screen_height)

        if vertex[3] == 4:
            cube_vertices_2d.append((vertex[0],vertex[1]))
        else:
            cube_vertices_2d.append((screen_x, screen_y))
        
    a,b,c,d = cube_vertices_2d[0],cube_vertices_2d[1],cube_vertices_2d[2],cube_vertices_2d[3]  
    
    # Print the 2D coordinates of the cube's vertices


    #draw_points(cube_vertices_2d[4][0],cube_vertices_2d[4][1],(0,0,0))
    #draw_points(cube_vertices_2d[7][0],cube_vertices_2d[7][1],(0,0,0))

    #draw_points(cube_vertices_2d[2][0],cube_vertices_2d[2][1],(0,0,0))
    #draw_points(cube_vertices_2d[6][0],cube_vertices_2d[6][1],(0,0,0))

    calculatePoints(a,b,c,d)


    for vertex in cube_vertices_2d:
        print(vertex,"!")
        draw_points(vertex[0],vertex[1],(0,0,0))

    print(a,b,c,d,"*-",player_y)
    fill(a,b,c,d)


lims_x = {}
lims_y = {}

def add_indexing_xy(x,y):
    if x in lims_x:
        if lims_x[x][0] > y:
            lims_x[x][0] = y
        if lims_x[x][1] < y:
            lims_x[x][1] = y
    else:
        lims_x[x] = [y,y] #min, max

    if y in lims_y:
        if lims_y[y][0] > x:
            lims_y[y][0] = x
        if lims_y[y][1] < x:
            lims_y[y][1] = x
    else:
        lims_y[y] = [x,x] #min, max

def calculate_line(a, b):
    print(a,b)
    x1, y1 = a
    x2, y2 = b

    dx = abs(x2 - x1)
    dy = abs(y2 - y1)
    sx = -1 if x1 > x2 else 1
    sy = -1 if y1 > y2 else 1

    if dx > dy:
        err = dx / 2.0
        while x1 != x2:
            draw_points(x1, y1,(0,0,0))
            add_indexing_xy(x1, y1)
            err -= dy
            if err < 0:
                y1 += sy
                err += dx
            x1 += sx
    else:
        err = dy / 2.0
        while y1 != y2:
            draw_points(x1, y1,(0,0,0))
            add_indexing_xy(x1, y1)
            err -= dx
            if err < 0:
                x1 += sx
                err += dy
            y1 += sy
    draw_points(x2, y2, (0,0,0))  # Ensure the last point (B) is drawn
    add_indexing_xy(x2, y2) 

def calculate_min_max(a,b,c,d):
    calculate_line(a,b)
    calculate_line(c,d)
    calculate_line(b,c)
    calculate_line(d,a)
    
    #print(lims_x)
    #print(lims_y)
    
    minX,minY,maxX,maxY = math.inf,math.inf,0,0
    for i in [a,b,c,d]:
        if i[0] < minX:
            minX = i[0]
        if i[0] > maxX:
            maxX = i[0]
        if i[1] < minY:
            minY = i[1]
        if i[1] > maxY:
            maxY = i[1]
    print(minX,maxX,minY,maxY)
    return minX,maxX,minY,maxY

def convert_to_integer(x, n, reversed):
    if reversed:
        x = 1 - x
    if x == 1:
        return n-1
    return int(x * n)

def fill(a,b,c,d):
    minX,maxX,minY,maxY = calculate_min_max(a,b,c,d)
    return
    for x in range(minX,maxX+1):
        for y in range(minY,maxY+1):
            if lims_x[x][0] <= y and lims_x[x][1] >= y:
                if lims_y[y][0] <= x and lims_y[y][1] >= x:
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





