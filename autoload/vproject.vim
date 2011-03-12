if exists("g:loaded_vproject") || &cp
    finish
endif

let g:loaded_vproject = 1
let s:vproject_debug = 0

function! s:ErrMsg(msg)
    echohl ErrorMsg
    echo a:msg
    echohl None
endfunction

function! s:dprint(msg)
    if s:vproject_debug == 1
        echom a:msg
    endif
endfunc

function! vproject#search()
    let file=findfile("project.vim", ".;")
    if !empty(file)
        let dir=fnamemodify(file, ":p:h")
        exe ':so ' . file
        if exists("*ProjectSetup")
            let InitFn=function("ProjectSetup")
            call InitFn(dir)
        else 
        endif
    endif
endfunc

function! vproject#start()
    augroup vproject_group
        au!
        au BufEnter *.c :call vproject#search()
        au BufEnter *.h :call vproject#search()
    augroup END
endfunc

