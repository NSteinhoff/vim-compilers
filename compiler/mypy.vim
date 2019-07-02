if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "mypy"

let s:pipenv = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p:h')
if !empty(s:pipenv)
    execute "lcd" . s:pipenv
    CompilerSet makeprg=pipenv\ run\ mypy\ --strict\ %
else
    CompilerSet makeprg=mypy\ --strict\ %
endif

CompilerSet errorformat=%f:%l:\ %m
