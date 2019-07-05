if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "pytest"

let s:project_root = fnamemodify(findfile('setup.py', expand('%:p:h') . ';' . expand('~')), ':p:h')

let s:command = ''
if !empty(s:project_root)
    let s:command .= 'cd ' . s:project_root . ' && '
endif

let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
if !empty(s:pipfile)
    let $PIPENV_PIPFILE = s:pipfile
    let s:command .= 'pipenv run '
endif

let s:command .= 'pytest --tb=short -q $*'

exec 'CompilerSet makeprg=' . escape(s:command, ' ')


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
