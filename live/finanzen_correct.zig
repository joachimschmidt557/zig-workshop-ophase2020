const std = @import("std");

const wanted_monat = "2";
const wanted_jahr = "2019";

pub fn main() !void {
    const stdin = std.io.getStdIn();
    var buffered_reader = std.io.bufferedReader(stdin.reader());
    const reader = buffered_reader.reader();

    var sum_cents: u32 = 0;
    var buf: [1024]u8 = undefined;
    while (try reader.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        var iterator = std.mem.split(line, ",");
        const datum = iterator.next() orelse return error.FalschesFormat;
        const preis = iterator.next() orelse return error.FalschesFormat;

        var datum_iterator = std.mem.split(datum, ".");
        const tag = datum_iterator.next() orelse return error.DatumFormat;
        const monat = datum_iterator.next() orelse return error.DatumFormat;
        const jahr = datum_iterator.next() orelse return error.DatumFormat;

        if (!std.mem.eql(u8, monat, wanted_monat)) continue;
        if (!std.mem.eql(u8, jahr, wanted_jahr)) continue;

        var preis_iterator = std.mem.split(preis, ".");
        const euro = preis_iterator.next() orelse return error.PreisFormat;
        const cent = preis_iterator.next() orelse return error.PreisFormat;

        const euro_parsed = try std.fmt.parseInt(u32, euro, 10);
        // € in UTF-8 is 3 bytes long, didn't remember that in the
        // live coding :)
        const cent_parsed = try std.fmt.parseInt(u32, cent[0 .. cent.len - 3], 10);

        sum_cents += euro_parsed * 100 + cent_parsed;
    }

    std.debug.warn("{}.{}€\n", .{ sum_cents / 100, sum_cents % 100 });
}
