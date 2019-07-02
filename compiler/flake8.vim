if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "flake8"

let s:pipenv = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p:h')
if !empty(s:pipenv)
    execute "lcd" . s:pipenv
    CompilerSet makeprg=pipenv\ run\ flake8
else
    CompilerSet makeprg=flake8
endif

CompilerSet errorformat=%f:%l:%c:\ %t%n\ %m
