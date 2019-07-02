if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "mypy"

if !empty(findfile('Pipfile', getcwd() . ';' . expand('~')))
    echo "Using pipenv " . system("pipenv --venv")
    CompilerSet makeprg=pipenv\ run\ mypy\ --strict\ %
else
    echo "Using global command"
    CompilerSet makeprg=mypy\ --strict\ %
endif

CompilerSet errorformat=%f:%l:\ %m
