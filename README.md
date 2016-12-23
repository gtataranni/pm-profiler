pm-profiler
============

This is an implementation of the poor man's profiler, using stack sampling \[1].

It works by sampling at random time interval a target executable, which is run in gdb.
Samples of the call stack are collected and plotted using [FlameGraphs][1].

Feel free to contribute.

Requirements
================

- [FlameGraphs][1]
- Stuff you normally have on a Linux distro: gdb, python, bash.

Usage
=========

	pm_profiler.sh path-to-exec gdb-commands-file output-dir


###### Notes:
> 1. Dunlavey M. Performance tuning with instruction-level cost derived from call-stack sampling. ACM SIGPLAN Notices [Internet]. Association for Computing Machinery (ACM); 2007 Aug 1;42(8):4–8. Available from: http://dx.doi.org/10.1145/1294297.1294298

[1]: https://github.com/brendangregg/FlameGraph