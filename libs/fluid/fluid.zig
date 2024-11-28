const std = @import("std");
const Bound = @import("bounds.zig").Bound;
const Particle = @import("particle.zig").Particle;
const Vector2 = @import("raylib").Vector2;

pub const Fluid = struct {
    particles: [1024]Particle = undefined,
    bounds: Bound,

    pub fn initFluid(bwidth: i32, bheight: i32) Fluid {
        var prng = std.Random.DefaultPrng.init(1);
        var r = prng.random();
        return Fluid{
            .particles = init: {
                var init_particles: [1024]Particle = undefined;
                for (&init_particles) |*p| {
                    p.* = Particle.initParticle(
                        @floatFromInt(r.intRangeAtMost(i32, 0, bwidth)),
                        @floatFromInt(r.intRangeAtMost(i32, 0, bheight)),
                    );
                }
                break :init init_particles;
            },
            .bounds = Bound.initBound(
                .{ .x = 0, .y = 0 },
                bwidth,
                bheight,
            ),
        };
    }

    pub fn updateFluid(f: *Fluid) void {
        for (&f.particles) |*p| {
            p.*.updateParticle(
                f.bounds.center,
                f.bounds.width,
                f.bounds.heigth,
            );
        }
    }

    pub fn drawFluid(f: *Fluid) void {
        for (&f.particles) |*p| {
            p.*.drawParticle();
        }
        f.bounds.drawBound();
    }
};
