if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "pytest"

if !empty(findfile('Pipfile', getcwd() . ';' . expand('~')))
    echo "Using pipenv " . system("pipenv --venv")
    CompilerSet makeprg=pipenv\ run\ pytest\ --tb=short\ -q
else
    echo "Using global command"
    CompilerSet makeprg=mypy\ --strict\ %
    CompilerSet makeprg=pytest\ --tb=short\ -q
endif

CompilerSet errorformat=
    \%-G%.%#FF%.%#,
    \%-G=%#\ FAILURES\ =%#,
    \%A_%#\ %m\ _%#,
    \%C%f:%l:%.%#,
    \%C>\ %#self%.%m,
    \%C>\ %#%m,
    \%ZE\ %#%m,
    \%-G%.%#seconds%.%#,
    \%-G%.%#
