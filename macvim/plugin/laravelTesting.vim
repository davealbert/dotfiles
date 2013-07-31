
if exists("loaded_laravelTesting")
    finish
endif
let loaded_laravelTesting = 1

command! -nargs=1 -complete=customlist,CompleteClassController Controller :call Controller(<q-args>)
command! -nargs=1 -complete=customlist,CompleteClassModel Model :call Model(<q-args>)

function! Model(Name)
    exec "tabedit app/tests/models/". a:Name.  "Test.php"
    exec "vsplit app/models/" . a:Name . ".php"
endfunction

function! Controller(Name)
    exec "tabedit app/tests/controllers/" . a:Name .  "ControllerTest.php"
    exec "vsplit app/controllers/" . a:Name . "Controller.php"
endfunction

function! CompleteClassController(a,b,c)
    let l:Result = split(glob("app/controllers/*.php"))
    let l:Result = map(l:Result, 'substitute(v:val, "^app/controllers/", "", "")')
    let l:Result = map(l:Result, 'substitute(v:val, "\.php$", "", "")')
    let l:Result = map(l:Result, 'substitute(v:val, "Controller$", "", "")')
    return l:Result
endfunction

function! CompleteClassModel(a,b,c)
    let l:Result = split(glob("app/models/*.php"))
    let l:Result = map(l:Result, 'substitute(v:val, "^app/models/", "", "")')
    let l:Result = map(l:Result, 'substitute(v:val, "\.php$", "", "")')
    return l:Result
endfunction

