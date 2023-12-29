import math
from PIL import Image, ImageTk
import tkinter as tk
import numpy as np

# LATEST VERSION !!!

# Player's position and orientation
player_x = 0 # You can adjust the player's position as needed
player_y = 0
player_z = -120
yaw = 0  # Adjust as needed (0 is front, 90 is left)
pitch = 0  # Adjust as needed (0 is neutral, positive angles tilt down)
fov = 90

screen_width = 160*4
screen_height = 90*4

blockSize = 80
blockSizeHalf = blockSize/2

def sumTuple(t1,t2):
    return tuple((x + y) for x, y in zip(t1, t2))

def distancePoint(t1):
    return math.sqrt(t1[0]*t1[0]+t1[1]*t1[1]+t1[2]*t1[2])

def convertToString(t1):
    return str(t1[0])+","+str(t1[1])+","+str(t1[2])

class Pixel():
    def __init__(self, a,b,c,d,col):
        self.a3 = a
        self.b3 = b
        self.c3 = c
        self.d3 = d
        self.color = col

    color = (0,0,0)

    a3 = (0,0,0)
    b3 = (0,0,0)
    c3 = (0,0,0)
    d3 = (0,0,0)
    
class Side():
    def __init__(self, xyz, t, texture):
        self.middlePoint = xyz
        self.type = t
        self.texture = texture
        if t == "right" or t == "left":
            self.a = sumTuple(xyz , (0,-40,-40))
            self.b = sumTuple(xyz , (0,40,-40))
            self.d = sumTuple(xyz , (0,-40,40))
            self.c = sumTuple(xyz , (0,40,40))
        
        elif t == "front" or t == "back":
            self.a = sumTuple(xyz , (-40,-40,0))
            self.b = sumTuple(xyz , (-40,40,0))
            self.d = sumTuple(xyz , (40,-40,0))
            self.c = sumTuple(xyz , (40,40,0))

        elif t == "up" or t == "down":
            self.a = sumTuple(xyz , (-40,0,-40))
            self.b = sumTuple(xyz , (-40,0,40))
            self.d = sumTuple(xyz , (40,0,-40))
            self.c = sumTuple(xyz , (40,0,40))
        
    distance = 0
    texture = ""    
    middlePoint = (0,0,0)
    type = ""
    a = (0,0,0)
    b = (0,0,0)
    c = (0,0,0)
    d = (0,0,0)


class Block():
    def __init__(self, xyz, texture):
        self.point = xyz
        self.sides = [
            Side(sumTuple(xyz,(blockSizeHalf,0,0)),"right",texture),
            Side(sumTuple(xyz,(-blockSizeHalf,0,0)),"left",texture),
            Side(sumTuple(xyz,(0,0,blockSizeHalf)),"back",texture),
            Side(sumTuple(xyz,(0,0,-blockSizeHalf)),"front",texture),
            Side(sumTuple(xyz,(0,blockSizeHalf,0)),"up",texture),
            Side(sumTuple(xyz,(0,-blockSizeHalf,0)),"down",texture)
            ]

    distance = 0
    point = (0,0,0)
    sides = []
    playerIsInside = False
    

def calculateRotation(point, player_x, player_y, player_z, player_yaw_deg, player_pitch_deg,):
    # Translate the point to be relative to the player position
    translated_vertex = (
        point[0] - player_x,
        point[1] - player_y,
        point[2] - player_z
    )

    # Rotate around the y-axis (yaw)
    rotated_vertex_yaw = (
        translated_vertex[0] * math.cos(player_yaw_deg) - translated_vertex[2] * math.sin(player_yaw_deg),
        translated_vertex[1],
        translated_vertex[0] * math.sin(player_yaw_deg) + translated_vertex[2] * math.cos(player_yaw_deg),
    )

    # Rotate around the x-axis (pitch) relative to yaw
    rotated_vertex_pitch = (
        rotated_vertex_yaw[0],
        rotated_vertex_yaw[1] * math.cos(player_pitch_deg) - rotated_vertex_yaw[2] * math.sin(player_pitch_deg),
        rotated_vertex_yaw[1] * math.sin(player_pitch_deg) + rotated_vertex_yaw[2] * math.cos(player_pitch_deg),
    )

    # Return the transformed point
    return rotated_vertex_pitch












image_path = r"D:\PYTHON\excel_minecraft\output-onlinepngtools (1).png"
grass_block_texture = Image.open(image_path)
grass_block_texture = grass_block_texture.convert('RGB')

def calculate_positions():
    blocks = [Block((0,0,0),"grass")]

    yaw_rad = math.radians(yaw)
    pitch_rad = math.radians(pitch)
    allSidesPre = {}
    allSquares = []

    # Applies rotation up/down/left/right to all points in blockSides and block
    for b in blocks:
        b.point = calculateRotation(b.point,player_x, player_y, player_z,yaw_rad,pitch_rad)
        b.distance = distancePoint(b.point)

    sorted_blocks = sorted(blocks, key=lambda x: x.distance, reverse=False)

    for b in sorted_blocks:

        currentBlockSidesPre = []

        for s in b.sides:
            s.middlePoint = calculateRotation(s.middlePoint,player_x, player_y, player_z,yaw_rad,pitch_rad)

            s.a = calculateRotation(s.a,player_x, player_y, player_z,yaw_rad,pitch_rad)
            s.b = calculateRotation(s.b,player_x, player_y, player_z,yaw_rad,pitch_rad)
            s.c = calculateRotation(s.c,player_x, player_y, player_z,yaw_rad,pitch_rad)
            s.d = calculateRotation(s.d,player_x, player_y, player_z,yaw_rad,pitch_rad)

            s.distance = distancePoint(s.middlePoint)

            currentBlockSidesPre.append(s)
        currentBlockSides = sorted(currentBlockSidesPre, key=lambda x: x.distance, reverse=True)

        if b.distance <= blockSize*math.sqrt(3):
            for i in range(6):
                allSidesPre[convertToString(currentBlockSides[i].middlePoint)] = currentBlockSides[i]
        else:
            for i in range(3):
                allSidesPre[convertToString(currentBlockSides[i].middlePoint)] = currentBlockSides[i]

    sorted_sides = sorted(allSidesPre.values(), key=lambda x: x.distance, reverse=False)

    for s in sorted_sides:
        for x in range(8):
            for y in range(8):
                col = (0,0,0)
                if s.type == "up":  
                    col = grass_block_texture.getpixel((x*10+5, 180+y*10+5))
                elif s.type == "down":  
                    col = grass_block_texture.getpixel((x*10+5, 0+y*10+5))
                else:   
                    col = grass_block_texture.getpixel((x*10+5, 90+y*10+5))

                if False:
                    if s.type == "up":
                        col = (255,0,0)
                    elif s.type == "left":
                        col = (0,255,0)
                    elif s.type == "front":
                        col = (0,0,255)
                    elif s.type == "down":
                        col = (255,0,255)
                    elif s.type == "back":
                        col = (255,255,0)
                    else:
                        col = (0,255,255)


                ad = ((s.d[0]-s.a[0])/8,(s.d[1]-s.a[1])/8,(s.d[2]-s.a[2])/8)
                ab = ((s.b[0]-s.a[0])/8,(s.b[1]-s.a[1])/8,(s.b[2]-s.a[2])/8)

                a = sumTuple(sumTuple(s.a, (ad[0]*(x), ad[1]*(x) , ad[2]*(x))),(ab[0]*(y), ab[1]*(y) , ab[2]*(y)))
                b = sumTuple(sumTuple(s.a, (ad[0]*(x), ad[1]*(x) , ad[2]*(x))),(ab[0]*(y+1), ab[1]*(y+1) , ab[2]*(y+1)))
                c = sumTuple(sumTuple(s.a, (ad[0]*(x+1), ad[1]*(x+1) , ad[2]*(x+1))),(ab[0]*(y+1), ab[1]*(y+1) , ab[2]*(y+1)))
                d = sumTuple(sumTuple(s.a, (ad[0]*(x+1), ad[1]*(x+1) , ad[2]*(x+1))),(ab[0]*(y), ab[1]*(y) , ab[2]*(y)))
                #print(a,b,c,d)
                allSquares.append(Pixel(a,b,c,d,col))
    return allSquares

root = tk.Tk()
root.title("Image Viewer")
canvas = tk.Canvas(root, width=screen_width, height=screen_height)
canvas.pack()

def clear_screen():
    global image
    image =  Image.new('RGB', (screen_width, screen_height), 'yellow') 

image = Image.new('RGB', (screen_width, screen_height), 'yellow') 
photo = ImageTk.PhotoImage(image)
canvas.create_image(0, 0, image=photo, anchor=tk.NW)

def save_points(x,y,c):
    screenPixels[y][x] = c

def draw_points(x,y,c):
    global image
    if 0 <= x < screen_width and 0 <= y < screen_height:
        image.putpixel((x, y), c)

def get_line_pixels(start, end, pixels_by_y,colorA):
    x0, y0 = start
    x1, y1 = end
    dx = abs(x1 - x0)
    dy = abs(y1 - y0)
    sx = -1 if x0 > x1 else 1
    sy = -1 if y0 > y1 else 1
    err = dx - dy

    while x0 != x1 or y0 != y1:
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



screenPixels = []

for y in range(screen_height):
    screenPixels.append([])
    for x in range(screen_width):
        screenPixels[y].append((-1,-1,-1))


def calculate(allSquares: list[Pixel]):
    for squaresA in allSquares:
        display = True
        colorA = squaresA.color
        pixels_by_y = {}
        allpixels = []
        square_vertices_2d = []
        resal = []
        # Apply the rotation and perspective projection to the square's vertices
        for intersection_point in [squaresA.a3,squaresA.b3,squaresA.c3,squaresA.d3]:
            # Translate the square's position relative to the player's position
                      
            def count_offclips():
                numberOfOffclips = 0
                if resal[0][2] <= 0:
                    numberOfOffclips+=1
                if resal[1][2] <= 0:
                    numberOfOffclips+=1
                if resal[2][2] <= 0:
                    numberOfOffclips+=1
                if resal[3][2] <= 0:
                    numberOfOffclips+=1
                #print("&",numberOfOffclips)
                return numberOfOffclips
            

            resal.append(intersection_point)

            # Perspective projection
            fov = 90  # Hodnota FOV v stupních

            # Přepočet FOV na radiany
            fov_rad = math.radians(fov)

            # Výpočet projekčních souřadnic s ohledem na FOV
            if int(intersection_point[2]) != 0:
                # Výpočet projekčních souřadnic s FOV
                projected_x = (intersection_point[0] / intersection_point[2]) * math.tan(fov_rad / 2)
                projected_y = (intersection_point[1] / intersection_point[2]) * math.tan(fov_rad / 2)
            else:
                intersection_point = (intersection_point[0], intersection_point[1], 1)
                # Výpočet projekčních souřadnic s FOV
                projected_x = (intersection_point[0] / intersection_point[2]) * math.tan(fov_rad / 2)
                projected_y = (intersection_point[1] / intersection_point[2]) * math.tan(fov_rad / 2)

            # Mapování na obrazovku
            screen_x = int((projected_x + 1) * 0.5 * screen_height + (screen_width - screen_height) / 2)
            screen_y = int((1 - projected_y) * 0.5 * screen_height)

            # Store the 2D coordinates in the dictionary
            #print(screen_x,screen_y)
            square_vertices_2d.append((screen_x,screen_y))
       
        if count_offclips() == 0:
            for i in range(4):
                start_point = square_vertices_2d[i]
                end_point = square_vertices_2d[(i + 1) % 4]
                get_line_pixels(start_point, end_point, pixels_by_y, colorA)

            min_y = min([point[1] for point in square_vertices_2d])
            max_y = max([point[1] for point in square_vertices_2d])

            if min_y <= 0:
                min_y = 1
            if max_y > screen_height:
                max_y = screen_height
            
            for y in range(min_y, max_y + 1):
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
    clear_screen()
    allSquares = calculate_positions()
    calculate(allSquares)
    update_image()
    print(player_x,player_y,player_z,pitch,yaw)
    
    s = input()
    for a in s:
        if a == "w":
            player_x -= int(-5 * math.sin(math.radians(yaw)) ) # Update x based on yaw
            player_z += int(5 * math.cos(math.radians(yaw))  ) # Update y based on yaw
        elif a == "s":
            player_x -= int(5 * math.sin(math.radians(yaw))  ) # Update x based on yaw
            player_z += int(-5 * math.cos(math.radians(yaw)))  # Update y based on yaw
        elif a == "a":
            player_x -= int(5 * math.cos(math.radians(yaw)) )  # Move left in player's perspective
            player_z += int(5 * math.sin(math.radians(yaw)) )  # Move left in player's perspective
        elif a == "d":
            player_x += int(5 * math.cos(math.radians(yaw)) )  # Move right in player's perspective
            player_z -= int(5 * math.sin(math.radians(yaw)) )  # Move right in player's perspective
        elif a == "e":
            yaw += 5
        elif a == "q":
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
        elif a == "x":
            player_y -= 5
        elif a == " ":
            player_y += 5

t.screen.mainloop()





