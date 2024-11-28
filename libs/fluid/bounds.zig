const Vector2 = @import("raylib").Vector2;
const DrawRectangleLines = @import("raylib").drawRectangleLines;
const rl = @import("raylib");

pub const Bound = struct {
    center: Vector2,
    width: i32,
    heigth: i32,

    pub fn initBound(c: Vector2, w: i32, h: i32) Bound {
        return Bound{
            .center = c,
            .width = w,
            .heigth = h,
        };
    }

    pub fn drawBound(self: *Bound) void {
        DrawRectangleLines(
            @intFromFloat(self.center.x),
            @intFromFloat(self.center.y),
            self.width,
            self.heigth,
            rl.Color.red,
        );
    }
};
