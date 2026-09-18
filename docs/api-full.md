
# Documentation

Namespaces: [main](#main)

---

# main

## Errors for 'main'

```js
// Thrown by every operation of this package.
error Error (connect, handshake, unsupported, error) payload { message: String, error_code: uint (0), sqlstate: String ("") }
```

### Error

Thrown by every operation of this package.

- `connect`: the TCP connection failed.
- `handshake`: logging in failed.
- `unsupported`: the server asked for something this package does not implement.
- `error`: the server reported an error. `error_code` holds its number, such as 1062 for a
  duplicate key, and `sqlstate` the five character state, such as `23000`.

## Enums for 'main'

```js
+ enum TYPE { null, int, float, string, array }
```

## Functions for 'main'

```js
+ fn connect(host: String, user: String, password: String, db: ?String, port: u32) Connection !Error
+ fn convert(ndata: $T) Value
// Returns the connection as a `sql.Db`, the database type of the `valk-sql` package.
+ fn database(con: Connection) Db
```

### database

Returns the connection as a `sql.Db`, the database type of the `valk-sql` package.

Everything `valk-sql` offers — the query builder, migrations, pools, rows read into your own
classes — then works on this database, and the same code runs on SQLite or Postgres by
opening it with their driver instead.

The connection itself stays usable: this is a view of it, not a replacement.

```valk
use sql
use mysql

let db = mysql.database(mysql.connect("127.0.0.1", "user", "password", "app", 3306) ! panic("%{E.message}"))
db.exec("INSERT INTO users (name) VALUES (?)", .{ sql.Value.of("Ada") }) ! panic("%{E.message}")
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
}
```

#### query_serial

Counts the statements that have run, so that the rows of a query can tell whether
another statement took the connection from under them.

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
