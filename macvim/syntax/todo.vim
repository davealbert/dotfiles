
"SpecialKey     xxx match 
                   "match 
                   "
                   "





syn match todoTask /\[\s\].*/ 
syn match todoComplete /\[x\].*/
syn match todoHead /\s.*|.*[0-3].*/
syn match todoHead2 /.*----.*/
syn match todoCal /^\~|.*/
syn match todoSkip /\[-\].*/


hi link todoTask Type
hi link todoComplete Comment
hi link todoHead SpecialKey
hi link todoHead2 SpecialKey
hi link todoCal Tag
hi link todoSkip SpellBad 
