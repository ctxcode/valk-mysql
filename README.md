
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
db.bind("name", "test")
db.bind("id", 1)
db.run("UPDATE users SET (name) VALUES (:name) WHERE id = :id") ! panic("Error: %EMSG")

// Nameless parameters
db.bindv("test")
db.bindv(10)
db.run("UPDATE users SET (name) VALUES (?) WHERE id = ?") ! panic("Error: %EMSG")

// Select
db.bind("id", 100)
db.select("SELECT * FROM users WHERE id > :id") ! panic("Error: %EMSG")

// Fetch 1-by-1
let columns : Array[?String] = .{}
while this.fetch_row(columns) ! panic("Error: %EMSG") {
    println("ROW DATA: " + columns.join(" | "))
}

// Fetch all
let users = db.fetch_all() ! { assert(false) return }
```
