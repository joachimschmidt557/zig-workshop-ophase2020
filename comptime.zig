const std = @import("std");

pub fn main() !void {
    const fib_numbers = comptime blk: {
        var result = [_]u32{0} ** 10;
        result[1] = 1;
        for (result) |*x, i| {
            if (i > 1) x.* = result[i - 2] + result[i - 1];
        }
        break :blk result;
    };

    for (fib_numbers) |x| std.debug.warn("{}\n", .{x});
}
