pm-profiler
============

This is an implementation of the poor man's profiler, using stack sampling [[1]](#notes).

It works by sampling at random time interval a target executable, which is run in gdb.
Samples of the call stack are collected and plotted using [FlameGraphs][flame-github] [[2]](#notes).

Feel free to contribute.

Requirements
================

- [FlameGraphs][flame-github]
- Stuff you normally have on a Linux distro: gdb, python, bash.

Usage
=========

- To see the names of the functions, the target binary may need to be compiled including the debugging symbols (`-g` option in `gcc`).
- Set appropriate parameters in [commands.gdb](./commands.gdb) and [pm_profiler.sh](./pm_profiler.sh) as described in the comments at the beginning of each file.
- To launch the profile use:
```
pm_profiler.sh path-to-exec gdb-commands-file output-dir
```
- If you want the Flame Graph only for the `main` function, you can run
```
sed '/^main/!d' samples.folded | flamegraph.pl > flame_out_main.svg
```


###### Notes:
> 1. Dunlavey M. Performance tuning with instruction-level cost derived from call-stack sampling. ACM SIGPLAN Notices [Internet]. Association for Computing Machinery (ACM); 2007 Aug 1;42(8):4–8. Available from: http://dx.doi.org/10.1145/1294297.1294298
> 2. Gregg B. The flame graph. Communications of the ACM. 2016 May 23;59(6):48-57. Available from: https://doi.org/10.1145/2909476

[flame-github]: https://github.com/brendangregg/FlameGraph
