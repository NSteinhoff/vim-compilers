if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "pytest"

let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
let s:is_test_file = match(expand('%'), 'test_') != -1
if !empty(s:pipfile)
    let $PIPENV_PIPFILE=s:pipfile
    if s:is_test_file
        CompilerSet makeprg=pipenv\ run\ pytest\ --tb=short\ -q\ %
    else
        CompilerSet makeprg=pipenv\ run\ pytest\ --tb=short\ -q\ #
    endif
else
    if s:is_test_file
        CompilerSet makeprg=pytest\ --tb=short\ -q\ %
    else
        CompilerSet makeprg=pytest\ --tb=short\ -q\ #
    endif
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
