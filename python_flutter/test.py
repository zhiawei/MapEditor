from flask import Flask, json, jsonify, request
from collections import deque

app = Flask(__name__)

# BFS algorithm implementation
def bfs(grid, start, goal):
    rows, cols = len(grid), len(grid[0])
    directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
    queue = deque([start])
    visited = set()
    parent = {}
    visited.add(start)
    parent[start] = None
    
    while queue:
        current = queue.popleft()
        
        if current == goal:
            break
        
        for d in directions:
            neighbor = (current[0] + d[0], current[1] + d[1])
            if (0 <= neighbor[0] < rows and 0 <= neighbor[1] < cols and
                neighbor not in visited and grid[neighbor[0]][neighbor[1]] != 'R'):
                queue.append(neighbor)
                visited.add(neighbor)
                parent[neighbor] = current
    
    path = []
    while goal in parent:
        path.append(goal)
        goal = parent[goal]
    path.reverse()
    
    return list(visited), path

@app.route('/bfs', methods=['POST'])
def bfs_endpoint():
    data = request.json
    
    # Print the received data
    print("Received data:")
    print(json.dumps(data, indent=4))
    
    grid = data['grid']
    start = (data['start']['x'], data['start']['y'])
    goal = (data['goal']['x'], data['goal']['y'])

    print(f"Start: {start}")
    print(f"Goal: {goal}")

    visited, path = bfs(grid, start, goal)
    
    return jsonify({
        # 'message': 'success',
        'visited': visited,
        'path': path
    })

if __name__ == '__main__':
    app.run(debug=True)
