if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "mypy"

CompilerSet makeprg=mypy\ --strict\ %

CompilerSet errorformat=%f:%l:\ %m
