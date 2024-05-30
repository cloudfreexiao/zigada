const std = @import("std");

const c = @cImport({
    @cInclude("ada_c.h");
});

pub const ParseError = error.ParseError;

pub const Url = struct {
    url: c.ada_url,

    const Self = @This();

    pub fn parse(input: []const u8) !Self {
        const url = c.ada_parse(input.ptr, input.len);
        if (!c.ada_is_valid(url)) {
            return ParseError;
        }
        return .{ .url = url };
    }

    pub fn parse_with_base(input: []const u8, base: []const u8) !Self {
        const url = c.ada_parse_with_base(input.ptr, input.len, base.ptr, base.len);
        if (!c.ada_is_valid(url)) {
            return ParseError;
        }
        return .{ .url = url };
    }

    pub fn deinit(self: Self) void {
        c.ada_free(self.url);
    }

    pub fn has_credentials(self: Self) bool {
        return c.ada_has_credentials(self.url);
    }

    pub fn has_empty_hostname(self: Self) bool {
        return c.ada_has_empty_hostname(self.url);
    }

    pub fn has_hostname(self: Self) bool {
        return c.ada_has_hostname(self.url);
    }

    pub fn has_non_empty_username(self: Self) bool {
        return c.ada_has_non_empty_username(self.url);
    }

    pub fn has_non_empty_password(self: Self) bool {
        return c.ada_has_non_empty_password(self.url);
    }

    pub fn has_port(self: Self) bool {
        return c.ada_has_port(self.url);
    }

    pub fn has_password(self: Self) bool {
        return c.ada_has_password(self.url);
    }

    pub fn has_hash(self: Self) bool {
        return c.ada_has_hash(self.url);
    }

    pub fn has_search(self: Self) bool {
        return c.ada_has_search(self.url);
    }

    pub fn get_href(self: Self) []const u8 {
        return as_string(c.ada_get_href(self.url));
    }

    pub fn get_username(self: Self) []const u8 {
        return as_string(c.ada_get_username(self.url));
    }

    pub fn get_password(self: Self) []const u8 {
        return as_string(c.ada_get_password(self.url));
    }

    pub fn get_port(self: Self) []const u8 {
        return as_string(c.ada_get_port(self.url));
    }

    pub fn get_hash(self: Self) []const u8 {
        return as_string(c.ada_get_hash(self.url));
    }

    pub fn get_host(self: Self) []const u8 {
        return as_string(c.ada_get_host(self.url));
    }

    pub fn get_hostname(self: Self) []const u8 {
        return as_string(c.ada_get_hostname(self.url));
    }

    pub fn get_pathname(self: Self) []const u8 {
        return as_string(c.ada_get_pathname(self.url));
    }

    pub fn get_search(self: Self) []const u8 {
        return as_string(c.ada_get_search(self.url));
    }

    pub fn get_protocol(self: Self) []const u8 {
        return as_string(c.ada_get_protocol(self.url));
    }

    pub fn set_href(self: Self, s: []const u8) !void {
        return must(c.ada_set_href(self.url, s.ptr, s.len));
    }

    pub fn set_host(self: Self, s: []const u8) !void {
        return must(c.ada_set_host(self.url, s.ptr, s.len));
    }

    pub fn set_hostname(self: Self, s: []const u8) !void {
        return must(c.ada_set_hostname(self.url, s.ptr, s.len));
    }

    pub fn set_protocol(self: Self, s: []const u8) !void {
        return must(c.ada_set_protocol(self.url, s.ptr, s.len));
    }

    pub fn set_username(self: Self, s: []const u8) !void {
        return must(c.ada_set_username(self.url, s.ptr, s.len));
    }

    pub fn set_password(self: Self, s: []const u8) !void {
        return must(c.ada_set_password(self.url, s.ptr, s.len));
    }

    pub fn set_port(self: Self, s: []const u8) !void {
        return must(c.ada_set_port(self.url, s.ptr, s.len));
    }

    pub fn set_pathname(self: Self, s: []const u8) !void {
        return must(c.ada_set_pathname(self.url, s.ptr, s.len));
    }

    pub fn set_search(self: Self, s: []const u8) void {
        c.ada_set_search(self.url, s.ptr, s.len);
    }

    pub fn set_hash(self: Self, s: []const u8) void {
        c.ada_set_hash(self.url, s.ptr, s.len);
    }
};

fn must(b: bool) !void {
    if (!b) {
        return ParseError;
    }
}

fn as_string(s: c.ada_string) []const u8 {
    return s.data[0..s.length];
}
