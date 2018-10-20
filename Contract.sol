pragma solidity ^0.4.19;

contract cryptaMaze{
    
    uint256[] maze;
    uint256 nonce = 0;
    uint x;
    uint y;
    
    function generateMaze(uint width, uint height) public returns(uint[]) {
        width = width * 3 + 2;
        height = height * 3 + 2;
        
        require(width >= 7);
        require(height >= 7);
        
        for(x = 0; x < width * height; x++) {
            maze[x] = 1;
        }
        
        maze[1 * width + 1] = 0;
        
        for(y = 0; y < height; y += 2) {
            for (x = 1; x < width; x += 2) {
                carveMaze(maze, width, height, x, y, nonce);
            }
        }
        
        maze[0 * width + 1] = 0;
        maze[(height - 1) * width + (width - 2)] = 0;
        
        return maze;
    }
    
    function carveMaze(uint[] maze,uint width,uint height,uint x,uint y, uint nonce) public {        
        uint dir;
        int x1;
        int y1;
        int x2;
        int y2;
        int dx;
        int dy;
        int count;
        
        dir = uint(keccak256(nonce, now)) % 4;
        count = 0;
        
        while(count < 4) {
            dx = 0;
            dy = 0;
            
            if(dir == 0) {
                dx = 1;
            }
            else if(dir == 1) {
                dy = 1;
            }
            else if(dir == 2) {
                dx = -1;
            } else {
                dy = -1;
            }
            
            x1 = int(x) + dx;
            y1 = int(y) + dy;
            x2 = x1 + dx;
            y2 = y1 + dy;
            
            if( x2 > 0 && x2 < int(width) && y2 > 0 && y2 < int(height) && maze[uint(y1 * int(width) + x1)] == 1 && maze[uint(y2 * int(width) + x2)] == 1) {
                maze[uint(y1 * int(width) + x1)] = 0;
                maze[uint(y2 * int(width) + x2)] = 0;
                x = uint(x2);
                y = uint(y2);
                
                nonce++;
                
                dir = uint(keccak256(nonce, now)) % 4;
                count = 0;
            } else {
                dir = (dir + 1) % 4;
                count++;
            }
            
        }
    }
    
    function spawnPlayer() public {
        
    }
    
    function trackPlayer() public {
        
    }
    
    function sendMazeData() public {
        
    }

}
