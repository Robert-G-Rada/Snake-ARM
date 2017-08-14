#define SCREEN_WIDTH    240
#define SCREEN_HEIGHT   160

#define MEM_IO          0x04000000
#define MEM_PAL         0x05000000
#define MEM_VRAM        0x06000000
#define MEM_OAM         0x07000000

#define KEY_RIGHT       0x0010
#define KEY_LEFT        0x0020
#define KEY_UP          0x0040
#define KEY_DOWN        0x0080
#define KEY_ANY         0x03FF

#define REG_KEY         0x04000130
#define REG_DISPCNT     0x04000000
#define REG_VCOUNT      0x04000006

#define WINDOW_WIDTH    12
#define WINDOW_HEIGHT   12
#define TILE_SIZE       8
#define WINDOW_X        (SCREEN_WIDTH - (TILE_SIZE * WINDOW_WIDTH)) / 2
#define WINDOW_Y        (SCREEN_HEIGHT - (TILE_SIZE * WINDOW_HEIGHT)) / 2
#define WINDOW_POS      MEM_VRAM + WINDOW_X * 2 + WINDOW_Y * SCREEN_WIDTH * 2

#define SNAKE_HEAD      0x02000000
#define MAX_COUNT       15

#define DIR_UP          1
#define DIR_RIGHT       2  
#define DIR_DOWN        3
#define DIR_LEFT        4
