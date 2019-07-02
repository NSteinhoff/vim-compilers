if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "mypy"

let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
if !empty(s:pipfile)
    let $PIPENV_PIPFILE=s:pipfile
    let $MYPYPATH=fnamemodify(s:pipfile, ':h')
    CompilerSet makeprg=pipenv\ run\ mypy\ --strict\ %
else
    CompilerSet makeprg=mypy\ --strict\ %
endif

CompilerSet errorformat=%f:%l:\ %m
