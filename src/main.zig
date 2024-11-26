const rl = @import("raylib");

const MAX_BUILDINGS = 100;

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig");
    defer rl.closeWindow();

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second

    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
    }
}
