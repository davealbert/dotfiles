" Vim global plugin to search over Stack Overflow inside Vim
" Last Change: 19 July 2013 
" Maintainer: Dave Albert < dave <dot> albert <at> gmail <dot> com >
" License: This file is placed in the public domain
" Example: :Stack how do I vim 

if exists("loaded_stackSearch")
  finish
endif
let loaded_stackSearch = 1

command -nargs=+ Stack call StackSearch(<f-args>)

function StackSearch(...)
	let q = substitute(join(a:000, " "), ' ', "+", "g")
    exe '! open -a Google\ Chrome.app http://stackoverflow.com/search?q=' . q 
endfunction
