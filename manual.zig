const std = @import("std");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = &gpa.allocator;

    var list = std.ArrayList(u32).init(allocator);
    try list.append(42);
    list.deinit();

    std.debug.warn("{}\n", .{list.items[0]});
}
