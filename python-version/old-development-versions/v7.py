import math,keyboard,os
from random import random
from PIL import Image, ImageTk
import tkinter as tk

screen_width = 640
screen_height = 320

k = 320

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



# front (X,-40,Z)

for y in range(int(80/10)):
    row = []
    for x in range(int(80/10)):  
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

colors = [
    [(255,0,0)],
    [(0,255,0)],
    [(0,0,255)],
    [(255,255,255)],
]

for i in range(4):
    for c in range(1,4):
        colors[i].append((int(colors[i][0][0] * ((4 - c) / 4)), int(colors[i][0][1] * ((4 - c) / 4)), int(colors[i][0][2] * ((4 - c) / 4))))

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

allSides = []


image_path = r"D:\PYTHON\excel_minecraft\output-onlinepngtools (1).png"
image = Image.open(image_path)

# Get the dimensions of the image
width, height = image.size
print(image.size)
# Initialize an empty list to store pixel data

def find_intersection(allPoints):
    Ax,Bx,Cx,Dx = allPoints
    x1, y1 = Ax
    x2, y2 = Bx
    x3, y3 = Cx
    x4, y4 = Dx
    
    # Parametric equations of the line segments
    denom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1)
    
    # Check if the line segments are not parallel
    if denom != 0:
        # Calculate the parameters for the intersection point
        t = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / denom
        u = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / denom

        # Check if the intersection point is within the line segments
        if 0 <= t <= 1 and 0 <= u <= 1:
            intersection_point = (x1 + t * (x2 - x1), y1 + t * (y2 - y1))
            return True, intersection_point

    # No intersection
    return False, None


def get_line_pixels(start, end, pixels_by_y,colorA):
    x0, y0 = start
    x1, y1 = end
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    sx = -1 if x0 > x1 else 1
    sy = -1 if y0 > y1 else 1
    err = dx - dy

    while x0 != x1 or y0 != y1:
        draw_points(x0, y0,colorA)
        if y0 not in pixels_by_y:
            pixels_by_y[y0] = set()
               # Check if the pixel is in front of the player (y >= 0)
        if y0 > 0 :#and y0 <= screen_height and x0 > 0 and x0 <= screen_width:
            pixels_by_y[y0].add(x0)
        e2 = 2 * err
        if e2 > -dy:
            err -= dy
            x0 += sx
        if e2 < dx:
            err += dx
            y0 += sy

def calculate():
    for squaresA in squares:
        display = True
        colorA = squaresA[4]
        pixels_by_y = {}
        allpixels = []
        yaw_rad = math.radians(yaw)
        pitch_rad = math.radians(pitch)
        print(yaw,"y")
        rotation_matrix = [
            [math.cos(yaw_rad), -math.sin(yaw_rad)],
            [math.sin(yaw_rad), math.cos(yaw_rad)]
        ]

        square_vertices_2d = []
        resal = []
        # Apply the rotation and perspective projection to the square's vertices
        for point in squaresA[:4]:
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


            def count_offclips():
                numberOfOffclips = 0
                if resal[0][1] <= 0:
                    numberOfOffclips+=1
                if resal[1][1] <= 0:
                    numberOfOffclips+=1
                if resal[2][1] <= 0:
                    numberOfOffclips+=1
                if resal[3][1] <= 0:
                    numberOfOffclips+=1
                print("&",numberOfOffclips)
                return numberOfOffclips

            if len(resal) >= 4 and count_offclips() >= 4:
                display = False


            # Check if the vertex is behind the player in 3D space
            print("!",rotated_vertex )
            if rotated_vertex[1] < 0:
                
                # Calculate the intersection with the XZ plane (where y = 0)
                t = -translated_vertex[1] / rotated_vertex[1]
                intersection_point = (
                    translated_vertex[0] + t * rotated_vertex[0],
                    -1,
                    translated_vertex[2] + t * rotated_vertex[2],
                    #-1,
                )
            else:
                intersection_point = rotated_vertex

            resal.append(intersection_point)

            

            # Apply yaw rotation
            rotated_x = intersection_point[0] * rotation_matrix[0][0] + intersection_point[1] * rotation_matrix[1][0]
            rotated_y = intersection_point[0] * rotation_matrix[0][1] + intersection_point[1] * rotation_matrix[1][1]

            # Perspective projection
            if int(rotated_y) != 0:
                projected_x = rotated_x / rotated_y
                projected_y = intersection_point[2] / rotated_y
            else:
                rotated_y = 1
                projected_x = rotated_x / rotated_y
                projected_y = intersection_point[2] / rotated_y


            # Map the projected coordinates to the screen space
            print(projected_x,rotated_x , rotated_y)
            screen_x = int((projected_x + 1) * 0.5 * k)
            screen_y = int((1 - projected_y) * 0.5 * k)

            # Store the 2D coordinates in the dictionary
            square_vertices_2d.append((screen_x,screen_y))

        def checkInside(square_vertices_2d):
            count = 0
            for i in square_vertices_2d:
                if i[0] > 0 and i[1] > 0 and i[0] <= screen_width and i[1] <= screen_height:
                    count+=1
            return count
        
        if display and checkInside(square_vertices_2d) >= 1 and not find_intersection(square_vertices_2d)[0]:
            print(square_vertices_2d,"*")
            for i in resal:
                print(i,"/*/")





            for i in square_vertices_2d:
                draw_points(i[0],i[1],colorA)

            for i in range(4):
                start_point = square_vertices_2d[i]
                end_point = square_vertices_2d[(i + 1) % 4]
                get_line_pixels(start_point, end_point, pixels_by_y, colorA)


            min_x = min([point[0] for point in square_vertices_2d])
            max_x = max([point[0] for point in square_vertices_2d])
            min_y = min([point[1] for point in square_vertices_2d])
            max_y = max([point[1] for point in square_vertices_2d])


            if min_y <= 0:
                min_y = 1
            if max_y > screen_height:
                max_y = screen_height
            

            for y in range(min_y, max_y + 1):
                #print(min_x,"*\n",max_x,"*\n",min_y,"*\n",max_y,"*\n",pixels_by_y[y],"*\n",pixels_by_y[y],"*\n")
                if y in pixels_by_y: 
                    if len(pixels_by_y[y]) > 0:
                        for x in range(min(pixels_by_y[y]), max(pixels_by_y[y]) + 1):
                            allpixels.append((x, y))
                            draw_points(x,y,colorA)

























def update_image():
    global image,photo,canvas
    photo = ImageTk.PhotoImage(image)
    canvas.create_image(0, 0, image=photo, anchor=tk.NW)
    

while True:
    s = input()
    for a in s:
        if a == "w":
            player_x += int(-5 * math.sin(math.radians(yaw)) ) # Update x based on yaw
            player_y += int(5 * math.cos(math.radians(yaw))  ) # Update y based on yaw
        elif a == "s":
            player_x += int(5 * math.sin(math.radians(yaw))  ) # Update x based on yaw
            player_y += int(-5 * math.cos(math.radians(yaw)))  # Update y based on yaw
        elif a == "a":
            player_x -= int(5 * math.cos(math.radians(yaw)) )  # Move left in player's perspective
            player_y -= int(5 * math.sin(math.radians(yaw)) )  # Move left in player's perspective
        elif a == "d":
            player_x += int(5 * math.cos(math.radians(yaw)) )  # Move right in player's perspective
            player_y += int(5 * math.sin(math.radians(yaw)) )  # Move right in player's perspective
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
            player_z -= 5
        elif a == "x":
            player_z += 5


    clear_screen()
    calculate()
    update_image()
    output_path = 'D:\\PYTHON\\excel_minecraft\\output.png'
    image.save(output_path)
    print(player_x,player_y,player_z,pitch,yaw)

    # Open the saved image (optional)

t.screen.mainloop()





