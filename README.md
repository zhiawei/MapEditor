# MapEditor

MapEditor is a comprehensive software tool designed to enhance the interpretability and transparency of AI models through advanced visualization and interactive exploration techniques. It enables researchers and developers to customize and visualize Grid World environments, facilitating efficient algorithm development, testing, and analysis. The tool is especially useful for visualizing search algorithms and providing educational insights into AI concepts.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [MapEditor Guide]()
- [API Integration]()
- [MapEditor Flutter build]()

## Features

- **Grid World Generation**: Easily create customizable grid maps with adjustable dimensions.
- **Environment Customization**: Add obstacles, start points, goal points, and more to design complex environments.
- **Algorithm Visualization**: Visualize and interact with various pathfinding and search algorithms directly within the tool.
- **Maze Generation**: Generate mazes using algorithms to create varied and challenging environments.
- **API Integration**: Connect MapEditor with external programming platforms to visualize custom algorithms. This allows the software to act as a frontend, with the API providing backend capabilities.
- **Export and Import**: Save your grid world configurations and load them later for further customization or testing.

## Installation

To install MapEditor, please follow these steps:

1. **Clone the Repository**:  
   ```bash
   git clone https://github.com/zhiawei/MapEditor.git

### Download Executable

To run **MapEditor** on your Windows machine, simply download the pre-built executable from the GitHub repository:

1. **Navigate to the [folder](https://github.com/zhiawei/MapEditor/tree/main/build/Release)**.
2. Download the folder.
3. Run the executable to start using MapEditor.

## MapEditor Guide

This section is to guide on how to use MapEditor

1. **Overview**
![watch the video](https://github.com/zhiawei/MapEditor/blob/main/asset/MapEditor_Showcase.gif)

   - **Menu Toolbar (A)**

      - **Save and load** : This functions allows users to save the current grid configuration as a JSON file and load previously saved grids. The saved JSON files can be exported and used in users' own experimentation within their preferred programming platforms
   - **Tool Pallete (B)**
      - **Tile Selection** : MapEditor palette provides users with options to select and place different types of tiles on the grid, such as start points, end points, and walls. It also includes a reset function to clear the grid, allowing for quick modifications and updates to the environment layout.
      - **Grid Text Display** : This feature allows users to toggle the display of the grid in its respective text representation. The text representation corresponds to the grid layout and tile types, providing a clear, textual overview of the grid configuration. When exported, this textual format serves as a reference for the specific arrangement of tiles.
   - **Grid Display (C)**
      - **Tile Placement and Removal** : Users can interact directly with the grid by left-clicking to place tiles and right-clicking to remove them.
   - **Control Panel (D)**
      - **Algorithm Selection** : Users can select from a variety of predefined search algorithms to visualize within the grid environment.
      - **Maze Selection** : This feature allows users to select a maze generation algorithm to populate the grid world.
      - **API Call** : MapEditor supports API integration, enabling users to connect MapEditor with their preferred programming platform. This allows users to visualize custom algorithms, with MapEditor functioning as the frontend interface and the external API serving as the backend processing unit.
      - **Speed Control** : A slider is available to adjust the speed of the algorithm visualization in real time.
   - **Grid Display Control (E)**
      - **Zoom Function** : Users can zoom in and out of the grid to focus on specific areas or view the entire environment.
      - **Grid Size Slider** : : A slider allows users to adjust the size of the grid world, expanding or contracting the grid dimensions in fixed square sizes (e.g., 10x10, 20x20).
   - **Information Panel (F)**
      - **Search Tile** : This panel displays the number of tiles the algorithm has searched before finding a path to the goal. 
      - **Basic Controls Information** : This feature provides users with hints and guidance on the basic controls of MapEditor, helping them quickly understand how to navigate and interact with the various functionalities.
   - **Log Panel (G)**
      - **Message Panel** : This panel is used to display error messages and other important notifications to the user during operation.
      - **Tile Log Panel** : The log panel tracks the sequence of tiles explored by the algorithm, including their coordinates and exploration order.

## API Integration

This repository contains a simple Flask-based API that implements the Breadth-First Search (BFS) algorithm. The API allows users to send a grid, start position, and goal position via a POST request and returns the list of visited nodes and the path from the start to the goal. This python is meant to be used as a template 

The python template can be found [here](https://github.com/zhiawei/MapEditor/blob/main/main/API_Testing.py). 

### Requirements

Before you begin, ensure you have met the following requirements:

- **Python 3.7+**: Make sure you have Python installed on your system.
- **Flask**: A lightweight WSGI web application framework. You can install it using `pip`.

```python
pip install flask
```

## MapEditor Flutter Build

The development build was originally made in Flutter. 

The folder can be found [here](https://github.com/zhiawei/MapEditor/blob/main/main/lib). 

The installation guide can be found [here](https://github.com/zhiawei/MapEditor/blob/main/Flutter%20Installation%20Guide.md). 

