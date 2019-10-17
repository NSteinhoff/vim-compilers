" Vim Compiler File
" Compiler:     mypy
" Maintainer:   Niko Steinhoff <niko.steinhoff@gmail.com>
" Last Change:  Thu 17 Oct 2019 09:31:16 CEST

" Standard boilerplate {{{
if exists("current_compiler")
  finish
endif
let current_compiler = "mypy"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif
"}}}

" Search the working directory for a pipfile.
"
" We want to run mypy from within the project environment
" when we're in a project that used pipenv to manage its
" virtualenv.
"
" When we find a Pipfile we run mypy through pipenv.
let s:pipfile = findfile('Pipfile', getcwd())
if !empty(s:pipfile)
    let s:pipenv = 'pipenv run '
else
    let s:pipenv = ''
endif

" Add the mypy invocation to the command.
"
" Use strict type checking!
let s:command = s:pipenv.'mypy --strict $* %'

exec 'CompilerSet makeprg=' . escape(s:command, ' ')

CompilerSet errorformat=%f:%l:\ %m

" vim: foldmethod=marker
