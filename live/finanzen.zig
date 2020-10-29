const std = @import("std");

const wanted_monat = "2";
const wanted_jahr = "2019";

pub fn main() !void {
    const stdin = std.io.getStdIn();
    var buffered_reader = std.io.bufferedReader(stdin.reader());
    const reader = buffered_reader.reader();

    var sum: u32 = 0;
    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var iterator = std.mem.split(line, ",");
        const datum = iterator.next() orelse return error.FalschesFormat;
        const preis = iterator.next() orelse return error.FalschesFormat;

        var datum_iterator = std.mem.split(datum, ".");
        var tag = datum_iterator.next() orelse return error.DatumFormat;
        var monat = datum_iterator.next() orelse return error.DatumFormat;
        var jahr = datum_iterator.next() orelse return error.DatumFormat;

        if (!std.mem.eql(u8, monat, wanted_monat)) continue;
        if (!std.mem.eql(u8, jahr, wanted_jahr)) continue;

        var preis_iterator = std.mem.split(preis, ".");
        var euro = preis_iterator.next() orelse return error.PreisFormat;

        sum += try std.fmt.parseInt(u32, euro, 10);
    }

    std.debug.warn("{}\n", .{sum});
}
