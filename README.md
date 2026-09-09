
# valk-mysql

A package to query mysql databases. The package is purely written in Valk and has no os-package dependencies.

Requires Valk 0.6.3 or newer.

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

## Development

`make test` runs the integration tests against MySQL/MariaDB at `127.0.0.1:3306`
with user `test` and password `root`. The tests create and use `valk_mysql_tests`.
`make example` builds and runs the local example. Override the compiler with
`make vc=/path/to/valk test`.
