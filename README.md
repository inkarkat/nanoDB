# Nano Database

_A primitive file-based dictionary supporting CRUD operations._

![Build Status](https://github.com/inkarkat/nanoDB/actions/workflows/build.yml/badge.svg)

This small tool serves as a minimal file-based persistent key-value database supporting CRUD operations with a single lookup key. Assuming infrequent access by a single application, there's no file locking.

Many applications implement this on their own (and usually within a few lines with `read` and `grep`); by delegating to this tool, one gets a robust yet small implementation, consistency in usage and storage locations, and the possibility to easily upgrade to the more powerful yet similar [`miniDB`](https://github.com/inkarkat/miniDB) API.

Each database "table" is represented as an individual file (put by default under `~/.local/share/[NAMESPACE/]TABLE`; the location can be customized via command-line arguments or `$XDG_DATA_HOME`). Each record is a line consisting of `KEY='VALUE'`, where VALUE is shell-quoted so that newlines and other special characters can be used. Values can be queried separately; alternatively, single records or the whole database can be gotten and `eval`'ed into proper shell variables.

## Dependencies

* Bash, GNU `sed`
* automated testing is done with _bats - Bash Automated Testing System_ (https://github.com/bats-core/bats-core)

## See also

* [miniDB](https://github.com/inkarkat/miniDB) offers multiple columns and transaction / file locking support behind a very similar API.
* [picoDB](https://github.com/inkarkat/picoDB) provides an even more primitive store of a set of keys (without values) behind a very similar API.
