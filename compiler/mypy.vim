if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "mypy"

let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
if !empty(s:pipfile)
    let s:pipenvroot = fnamemodify(s:pipfile, ':h')
    let $PIPENV_PIPFILE=s:pipfile
    let $MYPYPATH=s:pipenvroot . ':' . s:pipenvroot . '/src:' . s:pipenvroot . '/stubs'
    CompilerSet makeprg=pipenv\ run\ mypy\ --strict\ %
else
    CompilerSet makeprg=mypy\ --strict\ %
endif

CompilerSet errorformat=%f:%l:\ %m
