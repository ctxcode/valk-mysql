
# valk-mysql

A package to query mysql databases. The package is purely written in Valk and has no os-package dependencies.

## Install

```
vman install github.com/ctxcode/valk-mysql
```

## Example

```rust
// Init
let db = mysql:connect("127.0.0.1", "user", "password", "dbname", 3306) ! panic("Failed to connect: %EMSG")

// Run query + parameters
db.query("UPDATE users SET (name) VALUES (:name) WHERE id = :id", .{ "name" => "test", "id" => 1 }) ! panic("Error: %EMSG")

// Bind early
db.bind("name", "test")
db.query("UPDATE users SET (name) VALUES (:name) WHERE id = :id", .{ "id" => 1 }) ! panic("Error: %EMSG")

// Nameless parameters
db.bindv("test")
db.bindv(10)
db.query("UPDATE users SET (name) VALUES (?) WHERE id = ?") ! panic("Error: %EMSG")

// Select
db.select("SELECT * FROM users WHERE id > :id", .{ "id" => 10 }) ! panic("Error: %EMSG")

// Fetch 1-by-1
let user : Map[?String] = .{}
while this.fetch_row(user) ! panic("Error: %EMSG") {
    println("name: " + user["name"] ?? "/")
}

// Fetch all
let users = db.fetch_all() ! { assert(false) return }
```
