# Minecraft-Excel ![Minecraft Excel Logo](screenshots/minecraf-excel-logo.png) 
**Objective:**
This project aims to delve into the fundamental principles of rendering 3D objects in gaming engines. The chosen theme is to extend the reach of the global trend of porting older games, such as Doom, into various environments. The focus is on implementing basic graphical rendering of cubes, inspired by the game Minecraft, into the Microsoft Excel environment.

**Key Aspects:**
- Exploration of Excel as a programming environment for 3D games.
- Analysis of camera rotation, player movement, conversion to two dimensions, and other visualization aspects.
- Code optimization to minimize computations and enhance program speed.

**Structure:**
The work is divided into three main parts: theoretical foundation, implementation, and optimization. The theoretical section covers algorithms and mathematics related to 3D space movement. The implementation part details the integration into Excel, while the optimization section addresses environment limitations and program enhancements.

**Implementation Overview:**
- Frame calculation initiated by `Init`, triggering `Move` or keyboard input.
- Variables and environment parameters are loaded, and Block and Side data structures are created.
- Display the three nearest sides of each cube, sorted by distance.
- Coordinate calculation for vertices and side centers.
- Conversion of 3D to 2D, considering player perspective and visibility.
- Transformation of vertices into specific Excel cells, which are then converted into commands (row coloring).
- Statistics are recorded, and the program awaits further input.

**Conclusion:**
The project successfully implemented a program for rendering 3D cubes using 2D display in Microsoft Excel, utilizing Visual Basic for Applications. Despite the limitations of Excel for 3D programming, the information provided offers insights into the basics of 3D environments. The program has potential for improvement in both optimization and user interface aspects.
