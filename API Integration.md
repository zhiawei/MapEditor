# BFS Algorithm API with Flask

This repository contains a simple Flask-based API that implements the Breadth-First Search (BFS) algorithm. The API allows users to send a grid, start position, and goal position via a POST request and returns the list of visited nodes and the path from the start to the goal.

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the Application](#running-the-application)
- [API Usage](#api-usage)
- [Example Request](#example-request)
- [Contributing](#contributing)
- [License](#license)

## Features

- Implements BFS to find the shortest path in a grid.
- Returns visited nodes and the path from start to goal.
- Simple and easy-to-use RESTful API.

## Requirements

Before you begin, ensure you have met the following requirements:

- **Python 3.7+**: Make sure you have Python installed on your system.
- **Flask**: A lightweight WSGI web application framework. You can install it using `pip`.

## Installation

To install the necessary dependencies, follow these steps:

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/your-repo-name.git
    cd your-repo-name
    ```

2. **Create a virtual environment** (optional but recommended):

    ```bash
    python -m venv venv
    source venv/bin/activate  # On Windows use `venv\Scripts\activate`
    ```

3. **Install the dependencies**:

    ```bash
    pip install -r requirements.txt
    ```

    If you don't have a `requirements.txt` file, install Flask directly:

    ```bash
    pip install Flask
    ```

## Running the Application

To run the Flask application, follow these steps:

1. **Navigate to the directory** containing the `app.py` file (or whatever you named your script):

    ```bash
    cd path/to/your/github/folder
    ```

2. **Run the Flask application**:

    ```bash
    python app.py
    ```

3. **Access the application**:

    Once the server is running, it will be accessible at `http://127.0.0.1:5000` by default.

## API Usage

### Endpoint

- **POST** `/bfs`

### Request Body

The request body should be in JSON format and include the following fields:

- **grid**: A list of lists representing the grid (2D array).
- **start**: An object containing the `x` and `y` coordinates of the start position.
- **goal**: An object containing the `x` and `y` coordinates of the goal position.

### Example Request

Here's an example of how to use the API with `curl`:

```bash
curl -X POST http://127.0.0.1:5000/bfs -H "Content-Type: application/json" -d '{
  "grid": [
    ["W", "W", "W", "W", "W"],
    ["W", "R", "R", "R", "W"],
    ["W", "W", "W", "R", "W"],
    ["W", "R", "W", "R", "W"],
    ["W", "W", "W", "W", "W"]
  ],
  "start": {"x": 0, "y": 0},
  "goal": {"x": 4, "y": 4}
}'
