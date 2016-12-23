# by Giovanni TATARANNI
# https://github.com/gtataranni
#
# GDB script to print strack trace on kill signals
# customize the runtime parameter (last line)

set pagination 0
thread apply all bt
set logging file ~/poormanprofiler/gdb.log
#set logging overwrite on
set logging on
catch signal SIGINT
commands 1
bt 
continue
end
r # param_1 param_2 ... param_n