const std = @import("std");

const c = @cImport({
    @cInclude("stdlib.h");
    @cInclude("stdio.h");
    @cInclude("readline/readline.h");
});

pub fn main() !void {
    const input = c.readline("prompt> ");
    defer std.c.free(input);

    std.debug.warn("Your input was: {s}\n", .{input});
}
