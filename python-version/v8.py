import math
from PIL import Image, ImageTk
import tkinter as tk

# LATEST VERSION !!!

class Player():
    x = 0
    y = 0
    z = 0
    yaw = 0 
    pitch = 0 
    fov = 90


P = Player()

def start():
    P.x = 0  # You can adjust the player's position as needed
    P.y = 0
    P.z = -150
    P.yaw = 0  # Adjust as needed (0 is front, 90 is left)
    P.pitch = 0  # Adjust as needed (0 is neutral, positive angles tilt down)
    P.fov = 90

screen_width = 160*5
screen_height = 90*5

blockSize = 80
blockSizeHalf = blockSize/2

def sumTuple(t1,t2): #t1,t2 is tuple (0,1,2)
    return tuple((x + y) for x, y in zip(t1, t2))

def distancePoint(t1): #t1 is tuple (0,1,2)
    return math.sqrt(t1[0]*t1[0]+t1[1]*t1[1]+t1[2]*t1[2])

def convertToString(t1): #t1 is tuple (0,1,2)
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
        self.sides = [Side(sumTuple(xyz,(blockSizeHalf,0,0)),"right",texture),Side(sumTuple(xyz,(-blockSizeHalf,0,0)),"left",texture),Side(sumTuple(xyz,(0,0,blockSizeHalf)),"back",texture),Side(sumTuple(xyz,(0,0,-blockSizeHalf)),"front",texture),Side(sumTuple(xyz,(0,blockSizeHalf,0)),"up",texture),Side(sumTuple(xyz,(0,-blockSizeHalf,0)),"down",texture)]

    distance = 0
    point = (0,0,0)
    sides = []
    playerIsInside = False
    


def calculateRotation(point,yaw_rad,pitch_rad):
    translated_vertex = ( # DTTO
        point[0] - P.x,
        point[1] - P.y,
        point[2] - P.z
    )

    rotated_vertex_1 = (
        translated_vertex[0],
        translated_vertex[1] * math.cos(pitch_rad) - translated_vertex[2] * math.sin(pitch_rad),
        translated_vertex[1] * math.sin(pitch_rad) + translated_vertex[2] * math.cos(pitch_rad)
    )

    rotated_vertex = (
        rotated_vertex_1[0] * math.cos(yaw_rad) - rotated_vertex_1[2] * math.sin(yaw_rad),
        rotated_vertex_1[1],
        rotated_vertex_1[0] * math.sin(yaw_rad) + rotated_vertex_1[2] * math.cos(yaw_rad),
        
    )  

    return rotated_vertex

grass_block_texture = [[(0,0,0),(0,0,0),(0,0,0),(0,0,0)],[(0,0,0),(0,0,0),(0,0,0),(0,0,0)]] #rgb colors

def calculate_positions():
    blocks = []
    blocks.append(Block((0,0,0),"grass"))

    yaw_rad = math.radians(yaw)
    pitch_rad = math.radians(pitch)
    allSidesPre = {}
    allSquares = []

    # Applies rotation up/down/left/right to all points in blockSides and block
    for b in blocks:
        b.point = calculateRotation(b.point,yaw_rad,pitch_rad)
        b.distance = distancePoint(b.point)

    sorted_blocks = sorted(blocks, key=lambda x: x.distance, reverse=True)

    for b in sorted_blocks:

        currentBlockSidesPre = []

        for s in b.sides:
            s.middlePoint = calculateRotation(s.middlePoint,yaw_rad,pitch_rad)

            s.a = calculateRotation(s.a,yaw_rad,pitch_rad)
            s.b = calculateRotation(s.b,yaw_rad,pitch_rad)
            s.c = calculateRotation(s.c,yaw_rad,pitch_rad)
            s.d = calculateRotation(s.d,yaw_rad,pitch_rad)

            s.distance = distancePoint(s.middlePoint)

            currentBlockSidesPre.append(s)
        currentBlockSides = sorted(currentBlockSidesPre, key=lambda x: x.distance, reverse=False)

        if b.distance <= blockSize*math.sqrt(3):
            for i in range(6):
                allSidesPre[convertToString(currentBlockSides[i].middlePoint)] = currentBlockSides[i]
        else:
            for i in range(3):
                allSidesPre[convertToString(currentBlockSides[i].middlePoint)] = currentBlockSides[i]

    sorted_sides = sorted(allSidesPre.values(), key=lambda x: x.distance, reverse=True)

    for s in sorted_sides:
        for x in range(8):
            for y in range(8):
                col = (0,0,0)
                if s.type == "up":  
                    col = grass_block_texture.getpixel((x, 18+y))
                elif s.type == "down":  
                    col = grass_block_texture.getpixel((x, y))
                else:   
                    col = grass_block_texture.getpixel((x, 9+y))

                ad = ((s.d[0]-s.a[0])/8,(s.d[1]-s.a[1])/8,(s.d[2]-s.a[2])/8)
                ab = ((s.b[0]-s.a[0])/8,(s.b[1]-s.a[1])/8,(s.b[2]-s.a[2])/8)

                a = sumTuple(sumTuple(s.a, (ad[0]*(x), ad[1]*(x) , ad[2]*(x))),(ab[0]*(y), ab[1]*(y) , ab[2]*(y)))
                b = sumTuple(sumTuple(s.a, (ad[0]*(x), ad[1]*(x) , ad[2]*(x))),(ab[0]*(y+1), ab[1]*(y+1) , ab[2]*(y+1)))
                c = sumTuple(sumTuple(s.a, (ad[0]*(x+1), ad[1]*(x+1) , ad[2]*(x+1))),(ab[0]*(y+1), ab[1]*(y+1) , ab[2]*(y+1)))
                d = sumTuple(sumTuple(s.a, (ad[0]*(x+1), ad[1]*(x+1) , ad[2]*(x+1))),(ab[0]*(y), ab[1]*(y) , ab[2]*(y)))

                allSquares.append(Pixel(a,b,c,d,col))
    return allSquares



def clear_screen():
    for y in range(screen_height):
        for x in range(screen_width):
            Cells(y, x).Interior.Color = RGB(0, 0, 0) #excel set cell

def draw_points(x,y,c):
    if 0 <= x < screen_width and 0 <= y < screen_height:
        Cells(y, x).Interior.Color = c #excel set cell

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
        if y0 > 0:
            pixels_by_y[y0].add(x0)
        e2 = 2 * err
        if e2 > -dy:
            err -= dy
            x0 += sx
        if e2 < dx:
            err += dx
            y0 += sy

def calculate(allSquares: list[Pixel]):
    for squaresA in allSquares:
        display = True
        colorA = squaresA.color
        pixels_by_y = {}
        allpixels = []
        square_vertices_2d = []
        resal = []
        for intersection_point in [squaresA.a3,squaresA.b3,squaresA.c3,squaresA.d3]:
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
                return numberOfOffclips
            

            resal.append(intersection_point)

            if len(resal) >= 4 and count_offclips() > 0:
                display = False

            if int(intersection_point[2]) != 0:
                projected_x = intersection_point[0] / intersection_point[2]
                projected_y = intersection_point[1] / intersection_point[2]
            else:
                intersection_point = (intersection_point[0],intersection_point[1],1)
                projected_x = intersection_point[0] / intersection_point[2]
                projected_y = intersection_point[1] / intersection_point[2]

            screen_x = int((projected_x + 1) * 0.5 * screen_height + (screen_width -  screen_height)/2 )
            screen_y = int((1 - projected_y) * 0.5 * screen_height )
            square_vertices_2d.append((screen_x,screen_y))
       
        if display:
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



while True:
    clear_screen()
    allSquares = calculate_positions()
    calculate(allSquares)
    print(P.x,P.y,P.z,pitch,yaw)
    
    s = input()
    for a in s:
        if a == "w":
            P.x -= int(-5 * math.sin(math.radians(yaw)) ) # Update x based on yaw
            P.z += int(5 * math.cos(math.radians(yaw))  ) # Update y based on yaw
        elif a == "s":
            P.x -= int(5 * math.sin(math.radians(yaw))  ) # Update x based on yaw
            P.z += int(-5 * math.cos(math.radians(yaw)))  # Update y based on yaw
        elif a == "a":
            P.x -= int(5 * math.cos(math.radians(yaw)) )  # Move left in player's perspective
            P.z += int(5 * math.sin(math.radians(yaw)) )  # Move left in player's perspective
        elif a == "d":
            P.x += int(5 * math.cos(math.radians(yaw)) )  # Move right in player's perspective
            P.z -= int(5 * math.sin(math.radians(yaw)) )  # Move right in player's perspective
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
            P.y -= 5
        elif a == " ":
            P.y += 5

t.screen.mainloop()





