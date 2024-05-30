const std = @import("std");
const ada = @import("ada.zig");

fn print(s: []const u8) void {
    std.debug.print("{s}\n", .{s});
}

pub fn main() !void {
    const input = "https://username:password@www.google.com:8080/pathname?query=true#hash-exists";
    const url = try ada.Url.parse(input);
    defer url.deinit();
    print(url.get_href());
    print(url.get_protocol());
    print(url.get_username());

    try url.set_href("https://www.yagiz.co");
    url.set_hash("new-hash");
    try url.set_hostname("new-host");
    try url.set_host("changed-host:9090");
    try url.set_pathname("new-pathname");
    url.set_search("new-search");
    try url.set_protocol("wss");

    print(url.get_href()); // "wss://changed-host:9090/new-pathname?new-search#new-hash"
}

test "ada url test" {
    const input = "https://username:password@www.google.com:8080/pathname?query=true#hash-exists";
    const url = try ada.Url.parse(input);
    defer url.deinit();
    try std.testing.expectEqualStrings(
        "https://username:password@www.google.com:8080/pathname?query=true#hash-exists",
        url.href(),
    );
    try std.testing.expectEqualStrings(
        "https:",
        url.protocol(),
    );
    try std.testing.expectEqualStrings(
        "username",
        url.username(),
    );
}
