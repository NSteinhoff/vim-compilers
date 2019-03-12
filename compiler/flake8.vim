if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "flake8"

CompilerSet makeprg=flake8

CompilerSet errorformat=%f:%l:%l\ %t%n\ %m
