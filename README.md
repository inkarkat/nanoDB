# Nano Database

_A primitive file-based dictionary supporting CRUD operations._

This small tool serves as a minimal file-based key-value database supporting CRUD operations with a single lookup key. Assuming infrequent access by a single application, there's no file locking.

Many applications implement this on their own (and usually within a few lines with `read` and `grep`); by delegating to this tool, one gets a robust yet small implementation, consistency in usage and storage locations, and the possibility to easily upgrade to the more powerful yet similar [`miniDB`](https://github.com/inkarkat/miniDB) API.

Each database "table" is represented as an individual file (put by default under `~/.config/[NAMESPACE/]TABLE`, the location can be customized via command-line arguments or `$XDG_CONFIG_HOME`). Each record is a line consisting of `KEY='VALUE'`, where VALUE is shell-quoted so that newlines and other special characters can be used. Values can be queried separately; alternatively, single records or the whole database can be gotten and `eval`'ed into proper shell variables.

## Dependencies

* Bash, GNU `sed`
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)
