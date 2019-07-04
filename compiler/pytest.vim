if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "pytest"

let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
if !empty(s:pipfile)
    let $PIPENV_PIPFILE=s:pipfile
    CompilerSet makeprg=pipenv\ run\ pytest\ --tb=short\ -q\ %
else
    CompilerSet makeprg=pytest\ --tb=short\ -q\ %
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
