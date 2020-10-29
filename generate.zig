const std = @import("std");

const comments = [_][]const u8{
    "REWE",
    "Mensa",
    "Steam",
    "Lidl",
    "Spende",
};

const month_days = [_]u8{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

fn isLeapYear(year: u32) bool {
    if (year % 400 == 0)
        return true;
    if (year % 100 == 0)
        return false;
    return (year % 4 == 0);
}

fn numberOfDays(month: u8, year: u32) u8 {
    std.debug.assert(month <= 11);
    return if (month == 1 and isLeapYear(year)) 29 else month_days[month];
}

pub fn main() !void {
    var buf: [8]u8 = undefined;
    try std.crypto.randomBytes(buf[0..]);
    const seed = std.mem.readIntLittle(u64, buf[0..8]);

    var r = std.rand.DefaultPrng.init(seed);

    const stdout = std.io.getStdOut();
    var buffered_writer = std.io.bufferedWriter(stdout.writer());
    const writer = buffered_writer.writer();

    var i: usize = 0;
    while (i < 100_000_000) : (i += 1) {
        const price = r.random.uintAtMost(u32, 200_00);
        const comment = comments[r.random.uintLessThan(usize, comments.len)];

        const year = r.random.intRangeAtMost(u32, 2018, 2020);
        const month = r.random.uintLessThan(u8, 12);
        const day = r.random.uintLessThan(u8, numberOfDays(month, year));

        try writer.print("{}.{}.{},{}.{}€,{}\n", .{ day + 1, month + 1, year, price / 100, price % 100, comment });
    }

    try buffered_writer.flush();
}
