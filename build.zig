const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const optimize = b.standardOptimizeOption(.{});
    const exe = b.addExecutable(.{
        .name = "zigphys",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    const raylib = b.dependency("raylib-zig", .{
        .target = target,
        .optimize = optimize,
    });

    const raylib_module = raylib.module("raylib");
    const raylib_artifact = raylib.artifact("raylib");

    const particle_module = b.addModule(
        "particle",
        .{ .root_source_file = b.path("libs/fluid/particle.zig") },
    );
    particle_module.addImport("raylib", raylib.module("raylib"));
    particle_module.linkLibrary(raylib.artifact("raylib"));

    const fluid_module = b.addModule(
        "fluid",
        .{
            .root_source_file = b.path("libs/fluid/fluid.zig"),
        },
    );
    fluid_module.addImport("particle", particle_module);
    fluid_module.addImport("raylib", raylib_module);
    fluid_module.linkLibrary(raylib_artifact);

    exe.root_module.addImport("raylib", raylib_module);
    exe.root_module.addImport("fluid", fluid_module);

    exe.linkLibrary(raylib.artifact("raylib"));

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
