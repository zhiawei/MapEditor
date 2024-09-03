from flask import Flask, jsonify, request  # Import Flask and necessary modules for JSON handling
from collections import deque  # Import deque for efficient queue operations

app = Flask(__name__)  # Create a Flask application instance

# BFS algorithm implementation
def bfs(grid, start, goal):
    """
    Perform Breadth-First Search (BFS) on a grid to find the shortest path from start to goal.

    Args:
    - grid (list of list of str): The grid representing the maze or map where the search is performed.
    - start (tuple): The starting coordinates (x, y) of the search.
    - goal (tuple): The goal coordinates (x, y) where the search ends.

    Returns:
    - visited (list of tuples): List of all visited nodes in the order they were visited.
    - path (list of tuples): List of nodes representing the path from start to goal.
    """
    rows, cols = len(grid), len(grid[0])  # Determine the number of rows and columns in the grid
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]  # Define possible movement directions (right, down, left, up)
    queue = deque([start])  # Initialize the queue with the start position
    visited = []  # List to keep track of visited nodes
    parent = {}  # Dictionary to keep track of the parent nodes for path reconstruction
    visited.append(start)  # Mark the start node as visited
    parent[start] = None  # Start node has no parent

    # BFS loop
    while queue:
        current = queue.popleft()  # Dequeue the next node to explore

        # If the goal is reached, exit the loop
        if current == goal:
            break

        # Explore neighbors
        for d in directions:
            neighbor = (current[0] + d[0], current[1] + d[1])  # Calculate the neighbor's coordinates
            # Check if the neighbor is within the grid bounds, not visited, and not a blocked cell ('R' or 'X')
            if (0 <= neighbor[0] < rows and 0 <= neighbor[1] < cols and
                neighbor not in visited and grid[neighbor[0]][neighbor[1]] != 'R' and grid[neighbor[0]][neighbor[1]] != 'X'):
                queue.append(neighbor)  # Add neighbor to the queue for future exploration
                visited.append(neighbor)  # Mark neighbor as visited
                parent[neighbor] = current  # Set the current node as the parent of the neighbor

    # Reconstruct the path from goal to start
    path = []
    while goal in parent:  # Trace back from the goal to the start using the parent dictionary
        path.append(goal)
        goal = parent[goal]
    path.reverse()  # Reverse the path to start from the beginning

    return visited, path  # Return the visited nodes and the reconstructed path

# Flask route to handle BFS requests
@app.route('/bfs', methods=['POST'])
def bfs_endpoint():
    """
    Flask route to handle POST requests to the /bfs endpoint. This endpoint expects JSON data
    containing a grid, a start position, and a goal position, performs BFS, and returns the visited nodes
    and path.

    Returns:
    - JSON response containing the visited nodes and path.
    """
    data = request.json  # Get JSON data from the request
    
    # Extract grid, start, and goal from the data
    grid = data['grid']
    start = (data['start']['x'], data['start']['y'])
    goal = (data['goal']['x'], data['goal']['y'])

    # Perform BFS with the provided grid, start, and goal
    visited, path = bfs(grid, start, goal)
    
    # Return the result as a JSON response
    return jsonify({
        'visited': visited,
        'path': path
    })

if __name__ == '__main__':
    app.run(debug=True)  # Run the Flask app in debug mode
