const rl = @import("raylib");
const std = @import("std");

const Vector2 = rl.Vector2;
const CollisonDamp = 0.9;

pub const Particle = struct {
    position: Vector2,
    direction: Vector2,

    pub fn initParticle(xpos: f32, ypos: f32) Particle {
        return Particle{
            .position = Vector2{ .x = xpos, .y = ypos },
            .direction = Vector2{ .x = 0, .y = 0 },
        };
    }

    pub fn updateParticle(self: *Particle, c: Vector2, w: i32, h: i32) void {
        const float_w: f32 = @floatFromInt(w);
        const float_h: f32 = @floatFromInt(h);
        if (self.position.x <= c.x - float_w or self.position.x >= c.x + float_w) {
            self.direction.x *= -1 * CollisonDamp;
        }
        if (self.position.y <= c.y - float_h or self.position.y >= c.y + float_h) {
            self.direction.y *= -1 * CollisonDamp;
        }
        self.position.y += self.direction.y;
        self.position.x += self.direction.x;
    }

    pub fn drawParticle(self: *Particle) void {
        rl.drawEllipse(
            @intFromFloat(self.*.position.x),
            @intFromFloat(self.*.position.y),
            5.0,
            5.0,
            rl.Color{
                .r = 39,
                .g = 219,
                .b = 245,
                .a = 200,
            },
        );
    }
};
