# Minecraft-Excel ![Minecraft Excel Logo](screenshots/minecraf-excel-logo.png) 
Introduction
This project is a unique exploration into the world of 3D rendering within the familiar confines of Microsoft Excel. The primary goal is to understand and implement the basic principles of rendering 3D objects, with a specific focus on cubes inspired by the iconic game Minecraft.

## About:

Objective: Delve into the fundamental principles of 3D rendering.
Inspiration: Draw inspiration from the global trend of porting older games, like Doom, into diverse environments.
Implementation: Integrate basic graphical rendering of cubes into the Microsoft Excel environment.
Focus Areas: Explore Excel as a platform for programming 3D games, emphasizing camera rotation, player movement, and visualization aspects.
Optimization: Optimize code to minimize computations and enhance overall program speed.
What to Expect:

Theoretical Foundation: Understand the algorithms and mathematics behind 3D space movement.
Implementation Details: Dive into the specific integration of 3D rendering into the Excel environment.
Optimization Strategies: Address environment limitations and explore opportunities for program enhancement.
Why Minecraft-Excel?
This project serves as a creative endeavor to showcase the possibilities of combining spreadsheet software with 3D rendering. While Excel may seem an unconventional choice, the aim is to push the boundaries and provide a unique perspective on the fundamentals of 3D environments.

Note: The journey begins with a theoretical exploration, moves on to the nitty-gritty details of implementation, and concludes with optimization strategies. So, buckle up and let's explore the fascinating intersection of Excel and 3D rendering! 🌐✨

# Requirements

To run the Minecraft-Excel 3D Renderer, ensure your system meets the following requirements:

- **Microsoft Excel:**
  - Version: Excel 2016 or older
  - Edition: .exe version (not web app)

- **Operating System:**
  - Windows: 7 and above
  - Mac: macOS 12.0 and above

Please note that this project is designed to work with specific versions of Microsoft Excel and operating systems. Compatibility with other versions or platforms is not guaranteed. Ensure your system aligns with the specified requirements for the optimal functioning of the Minecraft-Excel 3D Renderer.

# Installation Steps

Follow these steps to install the Minecraft-Excel 3D Renderer:

1. **Download Minecraft.xlsm:**
   - Download the [`Minecraft.xlsm`](https://github.com/ProfiPoint/minecraft-excel/blob/main/Minecraft.xlsm) file from the project repository.

2. **Open File Properties:**
   - Right-click on the downloaded file.
   - Go to "Properties."

3. **General - Security Unblock:**
   - In the General tab, locate the "Security" section.
   - Check the "Unblock" option.
   - Click "OK" to confirm.

4. **Open File in Excel:**
   - Double-click on the [`Minecraft.xlsm`](https://github.com/ProfiPoint/minecraft-excel/blob/main/Minecraft.xlsm)  file to open it in Microsoft Excel.

5. **Access Excel Options:**
   - Go to the "File" tab in Excel.

6. **Navigate to Options:**
   - Click on "Options" at the bottom of the left-hand panel.

7. **Trust Center Settings:**
   - In the Excel Options dialog box, select "Trust Center" from the left-hand menu.

8. **Macro Settings:**
   - Click on "Trust Center Settings."

9. **Enable Macros:**
   - In the Trust Center dialog, choose "Macro Settings."
   - Select the option "Enable all macros."
   - Click "OK" to confirm.

10. **Enable Content:**
    - Close the options and click on "Enable Content" in the top line (Security warning - macros have been disabled).
   
You're now ready to explore the Minecraft-Excel 3D Renderer! Ensure that you've followed each step carefully to enable macros and unlock the full functionality of the program in Microsoft Excel.

## Alternative Installation Steps

If you prefer a manual installation or encounter any issues with the provided file, you can follow these steps to set up the Minecraft-Excel 3D Renderer:

1. **Create a New Excel File (.xlsm):**
   - Open Microsoft Excel.
   - Create a new Excel file and save it with the extension `.xlsm`.

2. **Access Visual Basic for Applications (VBA):**
   - Go to the "Developer" tab in Excel. (Note: If the Developer tab is not visible, you can enable it in Excel options.)

3. **Open Visual Basic:**
   - Click on "Visual Basic" in the Developer tab to open the Visual Basic for Applications (VBA) editor.

4. **Insert Modules and Class Modules:**
   - In the VBA editor, you'll see a project explorer on the left.
   - Right-click on your Excel file in the project explorer.
   - Choose "Import File" and manually add the following from `vba-version` files into the Macros:

     - `.bas` files: These are module files.
     - `.cls` files: These are class module files.

5. **Compile Code:**
   - Ensure that all the modules and class modules are successfully imported.
   - Compile the code to check for any errors.

6. **Save and Close:**
   - Save your Excel file.
   - Close the VBA editor.

7. **Enable Macros:**
   - Follow steps 5-10 from the previous installation instructions to enable macros and content in Excel.

You've now manually set up the Minecraft-Excel 3D Renderer by importing the necessary modules and class modules into the VBA editor. This alternative method allows for a more hands-on approach to the installation process. Explore and enjoy the 3D rendering capabilities within Excel!

# Using Program

## Controls

Experience Minecraft in Excel with these keyboard shortcuts. Ensure to bind these keys by using the 'Start' button on the 'Data' sheet. Note that all keys require the 'Shift' modifier.

1. **Move Up/Down**
   - *Shortcut:* Shift + Spacebar (Up), Shift + 'X' key (Down)
   - *Description:* Navigate along the Y-axis, allowing upward and downward movement.

2. **Move Left/Right**
   - *Shortcut:* Shift + 'A' key (Left), Shift + 'D' key (Right)
   - *Description:* Move along the X and Z axes, adjusting for camera orientation.

3. **Move Front/Back**
   - *Shortcut:* Shift + 'W' key (Front), Shift + 'S' key (Back)
   - *Description:* Move forward and backward along the X and Z axes, considering camera orientation.

4. **Look Up/Down**
   - *Shortcut:* Shift + 'R' key (Look Up), Shift + 'F' key (Look Down)
   - *Description:* Adjust the camera's pitch (X-axis rotation) for a vertical view.

5. **Look Left/Right**
   - *Shortcut:* Shift + 'Q' key (Look Left), Shift + 'E' key (Look Right)
   - *Description:* Control the camera's yaw (Y-axis rotation) to rotate around your own axis.

Or with buttons located in the 'Data' sheet.

## Variables

Customize the visual output of the program by adjusting these key parameters located in 'Data' sheet:

1. **Blocksize**
   - *Description:* Determines the length of each cube's side, serving as the coordinate scale.

2. **Screen Width & Screen Height**
   - *Description:* Represents the screen size in terms of cells.

3. **Movement & Rotation Coefficient**
   - *Description:* Scales player movement in specific directions and camera rotation in degrees along specific axes.

4. **InstantDrawing**
   - *Description:* Influences whether cells are gradually colored, aiding in visualizing the rendering process, or if all cells are colored without incremental rendering for faster display.

### Blocks

Customize cube textures and their center positions:

- *Default Texture:* NONE (not included)
- *Available Textures:* Choose from 16 predefined textures.
- *Coordinates:* Ensure unique coordinates as multiples of the cube's side length (Blocksize) to prevent overlap.

### Texture List

Explore the available cube textures through this list.

### Timestamps

Track program speed through precise timestamps:

- *Start Time:* Displays when the program was initiated.
- *Function Completion Times:* Indicates when individual frame calculation functions were completed.
- *Total Frame Calculation Time:* Shows the overall time for frame calculation from user input to cell display completion. Utilize this indicator for program optimization and testing.

**Note:** Modify cube textures in the 3rd sheet named "Textures" to personalize the appearance of the cubes in the program.

## Credits

This program was created with passion and dedication by [Ondřej Čopák]. Special thanks to the following contributors and resources:
ProfiPoint 2023

## Usage and Credits

Feel free to use this program for your own purposes, modify it, or integrate it into your projects. All I ask is proper crediting. If you find this tool helpful, give credit where credit is due.

### How to Credit:

- If you use this program in your project, mention in your documentation or credits that you utilized "Minecraft Excel" created by [Ondřej Čopák].
- Provide a link to the [GitHub repository](https://github.com/ProfiPoint/minecraft-excel) for others to explore and benefit.

Your support and adherence to these guidelines are greatly appreciated. Let's build and create together!
