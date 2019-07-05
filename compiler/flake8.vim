if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "flake8"

let s:command = ''
let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
if !empty(s:pipfile)
    let $PIPENV_PIPFILE = s:pipfile
    let s:command .= 'pipenv run '
endif

let s:command .= 'flake8 $* %'

exec 'CompilerSet makeprg=' . escape(s:command, ' ')

CompilerSet errorformat=%f:%l:%c:\ %t%n\ %m
