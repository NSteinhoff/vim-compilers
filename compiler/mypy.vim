if exists("current_compiler")
  finish
endif

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
let current_compiler = "mypy"

let s:project_root = fnamemodify(findfile('setup.py', expand('%:p:h') . ';' . expand('~')), ':p:h')

let s:command = ''
if !empty(s:project_root)
    let $MYPYPATH=s:project_root . ':' . s:project_root . '/src:' . s:project_root . '/stubs'
endif

let s:pipfile = fnamemodify(findfile('Pipfile', expand('%:p:h') . ';' . expand('~')), ':p')
if !empty(s:pipfile)
    let $PIPENV_PIPFILE = s:pipfile
    let s:command .= 'pipenv run '
endif

let s:command .= 'mypy --strict $* %'

exec 'CompilerSet makeprg=' . escape(s:command, ' ')

CompilerSet errorformat=%f:%l:\ %m
