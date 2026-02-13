

```rust
// Init

let db = mysq:Connection.new("127.0.0.1", "root", "root", "dbname", 3306)
// Run query
db.bindv("test")
db.bindv(10)
db.run("UPDATE users SET (name) VALUES (?) WHERE id = ?") ! panic("Error: %EMSG")

// Named parameters
db.bind("name", "test")
db.bind("id", 1)
db.run("UPDATE users SET (name) VALUES (:name) WHERE id = :id") ! panic("Error: %EMSG")

// Select
db.bind("id", 100)
db.select("SELECT * FROM users WHERE id > :id", fn(row: mysql:CurrentRow) {
    // Lookup by field index
    let id = row[0].int !? 0
    let name = row[1].string !? "missing"
    // Lookup by name (slower than index)
    let id = row.int("id") !? 0
    let name = row.string("name") !? "missing"
}) ! panic("Error: %EMSG")
```
