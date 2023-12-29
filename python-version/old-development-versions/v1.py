import math,keyboard,os
from turtle import *
from random import random

screen = Screen()

screen_width = 320
screen_height = 320
# Player's position and orientation
player_x = 0  # You can adjust the player's position as needed
player_y = -250
player_z = 0
yaw = 0  # Adjust as needed (0 is front, 90 is left)
pitch = 0  # Adjust as needed (0 is neutral, positive angles tilt up)
fov = 90

screen.setup(screen_width+4, screen_height+8)
screen.setworldcoordinates(0, 0, screen_width, screen_height)

t = Turtle()
t.speed(0)
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
    t.clear()

def draw_points(x,y,c):
    t.pencolor(rgb_to_turtle_color(c))
    t.penup()
    t.goto(x, y)
    t.pendown()
    t.dot(10)


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
    for vertex in cube:
        # Translate the cube's position relative to the player's position
        translated_vertex = (
            vertex[0] - player_x,
            vertex[1] - player_y,
            vertex[2] - player_z
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

            projected_x = rotated_x / 1 #? my code
            projected_y = rotated_vertex[2] / 1 #? my code
            #continue

        # Apply the perspective projection matrix
        projected_x *= d
        projected_y *= d

        # Map the projected coordinates to the screen space
        screen_x = int((projected_x + 1) * 0.5 * screen_width)
        screen_y = int((1 - projected_y) * 0.5 * screen_height)

        cube_vertices_2d.append((screen_x, screen_y))


    # Print the 2D coordinates of the cube's vertices
    screen.tracer(0) 

    draw_points(cube_vertices_2d[4][0],cube_vertices_2d[4][1],(0,0,0))
    draw_points(cube_vertices_2d[7][0],cube_vertices_2d[7][1],(0,0,0))

    draw_points(cube_vertices_2d[2][0],cube_vertices_2d[2][1],(0,0,0))
    draw_points(cube_vertices_2d[6][0],cube_vertices_2d[6][1],(0,0,0))

    calculatePoints(cube_vertices_2d[4],cube_vertices_2d[7],cube_vertices_2d[2],cube_vertices_2d[6])

    screen.update() 
    for vertex in cube_vertices_2d:
        print(vertex)
        draw_points(vertex[0],vertex[1],(0,0,0))

    fill(cube_vertices_2d[4],cube_vertices_2d[7],cube_vertices_2d[2],cube_vertices_2d[6])


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

def calculate_line(A, B):
    x1, y1 = A
    x2, y2 = B

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

def calculate_min_max(A,B,C,D):
    calculate_line(A,B)
    calculate_line(C,D)
    calculate_line(A,C)
    calculate_line(B,D)
    minX,minY,maxX,maxY = math.inf,math.inf,0,0
    for i in [A,B,C,D]:
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

def fill(A,B,C,D):
    minX,maxX,minY,maxY = calculate_min_max(A,B,C,D)
    for x in range(minX,maxX+1):
        for y in range(minY,maxY+1):
            if lims_x[x][0] <= y and lims_x[x][1] >= y:
                if lims_y[y][0] <= x and lims_y[y][1] >= x:
                    col = (255,128,0)
                    #print(lims_x[x][0] , y,lims_x[x][1] , lims_x[x][0], (lims_x[x][0] - y)/(lims_x[x][1] - lims_x[x][0]))
                    colX = convert_to_integer((lims_x[x][1] - y)/(lims_x[x][1] - lims_x[x][0]), 4, True)
                    colY = convert_to_integer((lims_y[y][1] - x)/(lims_y[y][1] - lims_y[y][0]), 4, False)
                    print(lims_x[x][1] , y,(lims_x[x][1] - y),(lims_x[x][1] - lims_x[x][0]))
                    print(colX,colY,colors[colY][colX])
                    draw_points(x,y,colors[colY][colX])

# Example usage
screen.tracer(0) 



screen.update() 


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

t.screen.mainloop()


