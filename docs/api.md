
# Documentation

Namespaces: [main](#main)

---

# main

## Errors for 'main'

```js
// Thrown by every operation of this package.
error Error (connect, handshake, unsupported, error) payload { message: String, error_code: uint (0), sqlstate: String ("") }
```

## Enums for 'main'

```js
// How a connection uses TLS.
+ enum SslMode { disable, prefer, require, verify_full }
+ enum TYPE { null, int, float, string, array }
```

## Functions for 'main'

```js
// Connects and logs in. TLS is used when the server offers it, without checking the certificate; `connect_with` takes other `SslOptions`.
+ fn connect(host: String, user: String, password: String, db: ?String, port: u32, ssl: SslMode (SslMode.prefer)) Connection !Error
// Connects and logs in with the TLS settings in `ssl`, such as a CA file to check the server certificate against, or a client certificate.
+ fn connect_with(host: String, user: String, password: String, db: ?String, port: u32, ssl: SslOptions) Connection !Error
+ fn convert(ndata: $T) Value
// Returns the connection as a `sql.Db`, the database type of the `valk-sql` package.
+ fn database(con: Connection) Db
```

## Classes for 'main'

```js
+ class Connection {
    ~ affected_rows: uint
    ~ closed: bool
    + debug: bool
    + debug_bytes: bool
    ~ last_inserted_id: uint
    // Counts the statements that have run, so that the rows of a query can tell whether another statement took the connection from under them.
    ~+ query_serial: uint

    + fn bind(name: String, value: $T) void
    + fn bindv(value: $T) void
    + fn clear_binds() void
    + fn clear_old_statements() void
    + fn close() void
    + fn fetch_all() Array[Map[Value]] !Error
    + fn fetch_row(row: Map[Value]) bool !Error
    + fn query(q: String, binds: ?Map[?Value] (null)) void !Error
    + fn replace_named_params(query: String) String !Error
    // Returns whether the connection runs over TLS.
    + fn ssl_enabled() bool
}
```

```js
// TLS settings for `connect_with`.
+ class SslOptions {
    // A PEM file with CA certificates to trust besides the system store, for a server certificate from a private CA. Only used in `verify_full` mode.
    + ca_file: ?String
    // A PEM file with the client certificate, optionally followed by the intermediate certificates, for an account that requires one (`REQUIRE X509`).
    + certificate_file: ?String
    // The password of an encrypted private key.
    + key_password: String
    // How TLS is used.
    + mode: SslMode
    // The PEM private key of `certificate_file`. Null reads it from `certificate_file`.
    + private_key_file: ?String
}
```

```js
+ class Value {
    + static fn null() Value
    + fn to_bool() bool
    + fn to_bool_or_null() ?bool
    + fn to_float() float
    + fn to_float_or_null() ?float
    + fn to_int() int
    + fn to_int_or_null() ?int
    + fn to_json() Value
    + fn to_json_or_null() ?(Value)
    + fn to_string() String
    + fn to_string_or_null() ?String
}
```
