const rl = @import("raylib");
const particle = @import("particle");
const fluid = @import("fluid");

pub fn main() anyerror!void {
    const screenWidth = 800;
    const screenHeight = 450;

    rl.initWindow(screenWidth, screenHeight, "raylib-zig");
    defer rl.closeWindow();

    var f = fluid.Fluid.initFluid(800, 450);

    rl.setTargetFPS(60); // Set our game to run at 60 frames-per-second

    while (!rl.windowShouldClose()) { // Detect window close button or ESC key
        f.updateFluid();

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.black);
        f.drawFluid();
    }
}
