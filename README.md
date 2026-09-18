
# valk-mysql

A package to query mysql databases. The package is purely written in Valk and has no os-package dependencies.

Requires Valk 0.7.3 or newer.

## Install

```
vman install github.com/ctxcode/valk-mysql
```

## Example

```rust
// Init
let db = mysql.connect("127.0.0.1", "user", "password", "dbname", 3306) ! panic("Failed to connect: %{E.message}")

// Run query + parameters
db.query("UPDATE users SET name = :name WHERE id = :id", .{ "name" => "test", "id" => 1 }) ! panic("Error: %{E.message}")

// Bind early
db.bind("name", "test")
db.query("UPDATE users SET name = :name WHERE id = :id", .{ "id" => 1 }) ! panic("Error: %{E.message}")

// Nameless parameters
db.bindv("test")
db.bindv(10)
db.query("UPDATE users SET name = ? WHERE id = ?") ! panic("Error: %{E.message}")

// Select
db.query("SELECT * FROM users WHERE id > :id", .{ "id" => 10 }) ! panic("Error: %{E.message}")

// Fetch 1-by-1
let user : Map[mysql.Value] = .{}
while db.fetch_row(user) ! panic("Error: %{E.message}") {
    println("name: " + (user["name"] ?? "/"))
}

// Fetch all
let users = db.fetch_all() ! { assert(false) return }
```

## With valk-sql

`mysql.database(con)` turns a connection into a `sql.Db` of the
[valk-sql](https://github.com/ctxcode/valk-sql) package, which gives every database the same
API: a query builder, migrations, connection pools, and rows read into your own classes. The
same program then runs on another database by opening it with that driver instead.

```rust
use sql
use mysql

let db = mysql.database(mysql.connect("127.0.0.1", "user", "password", "app", 3306) ! panic("%{E.message}"))
db.exec("INSERT INTO users (name, age) VALUES (?, ?)", .{ sql.Value.of("Ada"), sql.Value.of_int(36) }) ! panic("%{E.message}")
let rows = db.all("SELECT * FROM users WHERE age > ?", .{ sql.Value.of_int(18) }) ! panic("%{E.message}")
```

The connection itself keeps working as before: the wrapper is a view of it, and the driver's own
API stays there for the paths where every allocation counts.

## Development

`make server` starts a MySQL in docker on port 3306 with the user the tests use, and
`make server-down` removes it again; a machine that already runs MySQL there needs neither.

`make deps` fetches the `valk-sql` package the `database()` adapter needs; the tests build
against it from `vendor/`.

`make test` runs the integration tests against MySQL/MariaDB at `127.0.0.1:3306`
with user `test` and password `root`. The tests create and use `valk_mysql_tests`.
`make example` builds and runs the local example. Override the compiler with
`make vc=/path/to/valk test`.
