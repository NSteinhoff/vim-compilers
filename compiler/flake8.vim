if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "flake8"

if !empty(findfile('Pipfile', getcwd() . ';' . expand('~')))
    echo "Using pipenv " . system("pipenv --venv")
    CompilerSet makeprg=pipenv\ run\ flake8
else
    echo "Using global command"
    CompilerSet makeprg=flake8
endif

CompilerSet errorformat=%f:%l:%c:\ %t%n\ %m
