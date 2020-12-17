" Mappings based on autocommands.
" Autocommands can also be chained.
" au Filetype javascript nn <buffer> <M-a> :!node %<cr>
" <buffer> points to the script the com was declared in
" nn <buffer> <leader>l :echom expand('%')<cr>
" OPERATOR-PENDING MAPPING
" :normal hides the effect of the preceding operator
" onoremap in( :<c-u>normal! f(vi(<cr>
" onoremap in( :<c-u>normal! f{vi}<cr>
" normal does not recognise special symbols like <cr>
" hence we use execute
" ono ih :<c-u>execute "normal! ?^==\\+$\r:noh\rkvg_"<cr>
" see pattern-overview
" file, dirty, row, col, pos
" select first, then apply
" %-0{minwid}.{maxwid}{item}
" set statusline=[%-4l]
" In visual mode, a simple "S" with an argument wraps the selection
" A t is a pair of HTML or XML tags.  See |tag-blocks| for details.  Remember
" that you can specify a numerical argument if you want to get to a tag other
" than the innermost one.
" <div>Yo!</div> -> Yo!
" set statusline=%<%f\ %m%=%y\ %r%{FugitiveStatusline()}\ [%l,%c%V]\ %3p%{nr2char(37)}
" let w='abc'
" let w=w " reassign like so
" echo w
" echo &textwidth " access options
" <Ctrl+[register name]> to paste it's value (in cmdline or insert mode)
" @/"+[register name]
" to add to a writable register, say @w, do let @W=@a (uppercase == +=)
" "+ is the clipboard register
" "0 stores latest yank, others have deleted text
" "/? search registers
" Use & to refer already existing options
" set -> &g:, setlocal -> &l:
" internal-variables
" Commands (let ...), Expressions(5+5), and Literals(variables -> echo ...)
" let g:rexagod = 1 " eg exists(g:rexagod)
" let b:rexagod = 2
" let &b:number=0 " eg exists(&g:number)
" separate commands in single line using: <bar> or |, eg., :echom "foo" | echom "bar"
" we can use "x after the command to store that in register x
" wont work for "0..." or "..."
" if "1-ty-one" 
"   echo 11
" endif
" if 0
"   echo 0
" elseif "falsy"
"   echo "nop"
" else
"   echo "finally"
" endif
" ". contains the last inserted text
" if 10 > 1
"   echo ">"
" endif
" gF(number preceeded by filename) or just gf to open file under cursor, try: ~/.vimrc
" if 10 == 11
"   echo "here"
" elseif 10 == 10
"   echo "or here"
" endif
" == depends upon user settings
" set ignorecase
" if "foo" == "FOO"
"     echom "vim is case insensitive"
" elseif "foo" == "foo"
"     echom "vim is case sensitive"
" endif
" set noignorecase
" if "foo" == "FOO"
"     echom "vim is case insensitive"
" elseif "foo" == "foo"
"     echom "vim is case sensitive"
" endif
" ==# -> strict case-sensitive
" ==? -> strict case-insensitive
" see expr4
" function Say()
"   echo "hi"
" endfunction
" call Say()
" " reassignment
" function! Say()
"   return 2
" endfunction
" echom Say()
" | -> cmdline, <bar> -> mappings
" function Nop()
"   " returns 0 as implicit value
" endfunction
" function Varg2(foo, ...)
"   echom a:foo
"   " all these refer the varargs
"   echom a:0
"   echom a:1
"   echo a:000
" endfunction
" call Varg2("a", "b", "c")
" function AssignGood(foo)
"   let foo_tmp = a:foo
"   let foo_tmp = "Yep"
"   echom foo_tmp
" endfunction
" call AssignGood("test")
" function Assign(foo)
"   let a:foo = "Nope" " cannot assign directly to args
"   echom a:foo
" endfunction
" call Assign("test")
" let n=17
" exe "echo 0".n
" echo 0x15
" echo 015
" echo 15
" echo 2.43e7
" echo 2.43e6
" echo 2e3 " error
" echo 2.0e3 " works
" echo 2 * 2.0
" echo 3/2.0
" + is only for numbers. Use . for concatentations.
" echo "3 x" + "4 y"
" echo 10 + "10.10"
" echo "x" + "y"
" works as expected since . operator is used
" not works with floats, though, since >1 decimals cause ambiguity
" echo 10 . "foo" 
" let @B="z"
" Literal Strings: '...'
" ''(=') is the only sequence with a special meaning inside '...' while all others
" are left as-is.
" echo '\n\\'''
" echo strlen("foo")
" echo len("bar")
" echo split("foo bar baz")
" echo split("foo,bar,baz",",")
" echo join(["FOO","BAR","BAZ"])
" echo tolower(["FOO"][0])
" echo toupper(["FOO"][0])
" help string-functions
" echo sha256("rexagod")
" normal does not parse special char sequences like <esc>,
" hence, use execute
" exe "normal[!->nn] ggvG$\<esc>oi"
" \ escape sequences only work inside "", not ''
" hence, special vim-sequences such as <cr> need to be inside
" "" inorder to be escaped
" help g
" no need to worry about regex anymore!
" nn / /\v
" max = 10
" print "Starting"
" for i in range(max):
"   print "Counter:", i
"   print "Done"
" to search for the for loop
" exe "normal! gg/for .\\+ in .\\+:\<cr>:noh\<cr>"
" or
" exe 'normal! gg/for .\+ in .\+:' . "\<cr>" . ':noh' . "\<cr>"
" or
" exe "normal! gg/\\vfor .+ in .+:\<cr>:noh\<cr>"
"                 ^^              ^        ^
"                 escaped later   escaped immediately
"                 on search exec
" :g/pattern/{any Ex mode command (commands that can be exec using :)
" a: prev/next ???
" b: buffer
" l: llist
" q: error/qflist
" f: files
" t: tags
" n: conflicts
" e: exchange
" space: o
" yos: spell
" yoc: lineh
" yol: list(special chars)
" yod: diffthis 
" you: colh
" (nothing) In a function: local to a function; otherwise: global
" |buffer-variable|    b:	  Local to the current buffer.
" |window-variable|    w:	  Local to the current window.
" |tabpage-variable|   t:	  Local to the current tab page.
" |global-variable|    g:	  Global.
" |local-variable|     l:	  Local to a function.
" |script-variable|    s:	  Local to a |:source|'ed Vim script.
" |function-argument|  a:	  Function argument (only inside a function).
" |vim-variable|       v:	  Global, predefined by Vim.
" word = foo
" WORD = foo-bar
" Passing \_ to grep will automatically remove the \
" Escape {string} for use as a shell command argument.
" On MS-Windows, when 'shellslash' is not set, it will enclose
" {string} in double quotes and double all double quotes within
" {string}.
" without 1 -> Otherwise it will enclose {string} in single quotes and
" replace all "'" with "'\''".
" with 1 -> When the {special} argument is present and it's a non-zero
" Number or a non-empty String (|non-zero-arg|), then special
" items such as "!", "%", "#" and "<cword>" will be preceded by
" a backslash.  This backslash will be removed again by the |:!|
" command.
" foo;l\s
" that's
" nn <silent><buffer><space>g :exec "grep! -R " . shellescape(expand('<cWORD>')) . " *"<cr>:copen<cr>
" help g@
"g@{motion}		Call the function set by the 'operatorfunc' option.
"			The '[ mark is positioned at the start of the text
"			moved over by {motion}, the '] mark on the last
"			character of the text.
"			The function is called with one String argument:
"			    "line"	{motion} was |linewise|
"			    "char"	{motion} was |characterwise|
"			    "block"	{motion} was |blockwise-visual|
"			Although "block" would rarely appear, since it can
"			only result from Visual mode where "g@" is not useful.
"			{not available when compiled without the |+eval|
"			feature}
" v (charwise), V(linewise), <c-v>(blockwise)
" function! s:ToggleQuickFix()
"   if empty(filter(getwininfo(), 'v:val.quickfix'))
"     copen
"   else
"     cclose
"   endif
" endfunction
" function! s:Grepper(type)
"   let l:bkreg=@@
"   if a:type ==# 'v'
"     normal! `<v`>y
"   elseif a:type ==# 'char'
"     normal! `[y`]
"   endif
"   silent exe "grep! -R " . shellescape(@@) . " *"
"   let @@=l:bkreg
"   copen
" endfunction
" nn <leader>qf :call <SID>ToggleQuickFix()<cr>
" nn <leader>gg :set opfunc=<SID>Grepper<cr>g@
" vn <leader>gg :<c-u>call <SID>Grepper(visualmode())<cr>
" Use <c-y>, <c-e> in i mode to copy above/below characters
" echo ['a',[2],'b'][-2][0]
" cannot use negative bare indices with strings, we can use negative
" indices when slicing strings though
" echo [1,2,3,4,5][2:-2]
" echo "abcd"[1:-2]
" " empty string
" echo "abcd"[-2] 
" let foo = [1,2,3]
" echo add(foo,4)
" echo get(foo,-1,0)
" echo get(foo,-10,0)
" echo index(foo,2)
" echo join(foo)
" echo join(foo,' ')
" echo reverse(foo)
" echo uniq(sort(foo))
" let foo+=[0]
" let foo=[0]+foo
" echo foo
" simply assigning a list to another variable will pass the list to that
" variable using pass-by-reference. for pass-by-value, use deepcopy().
" 4 == "4" but [4] != ["4"], i.e., list-comparisions are strict
" let [a,b;rest]=foo
" echo [a,b]
" let foo[1:-1]=[1,1]
" use add to append, insert to prepend
" insert(foo,'1') "insert at 0
" insert(foo,'1',3) "insert at 3
" Useful list functions
" :let r = call(funcname, list)	" call a function with an argument list
" :if empty(list)			" check if list is empty
" :let l = len(list)		" number of items in list
" :let big = max(list)		" maximum value in list
" :let small = min(list)		" minimum value in list
" :let xs = count(list, 'x')	" count nr of times 'x' appears in list
" :let i = index(list, 'x')	" index of first 'x' in list
" :let lines = getline(1, 10)	" get ten text lines from buffer
" :call append('$', lines)	" append text lines in buffer
" :let list = split("a b c")	" create list from items in a string
" :let string = join(list, ', ')	" create string from list items
" :let s = string(list)		" String representation of list
" :call map(list, '">> " . v:val')  " prepend ">> " to each item
" Don't forget that a combination of features can make things simple.  For
" example, to add up all the numbers in a list: >
" :exe 'let sum = ' . join(nrlist, '+')
" 
" (/usr/share/vim/vim81/doc/eval.txt:343)
" An extra comma after the last item is ignored.
" g/^$/d
" gi to go back where cursor was last time in i mode
" :echo {'a': 1, 100: 'foo',}.100
" :let foo = {'a': 1}
" :let foo.a = 100
" :let foo.b = 200
" :echo foo
" :let test = remove(foo, 'a')
" :unlet foo.b
" :echo foo
" :echo test
" :unlet foo["asdf"]
" Vim throws an error.
" :echom get({'a': 100}, 'b', 'default')
" :echom has_key({'a': 100}, 'b')
" echo items({'a': 100, 'b': 200})
" To avoid having to put quotes around every key the #{} form can be used.  This
" does require the key to consist only of ASCII letters, digits, '-' and '_'.
" Example: >
"   let mydict = #{zero: 0, one_key: 1, two-key: 2, 333: 3}
"   Note that 333 here is the string "333".  Empty keys are not possible with
"   #{}.
" Merging a Dictionary with another is done with |extend()|: >
" :call extend(adict, bdict)
" This extends adict with all entries from bdict.  Duplicate keys cause entries
" in adict to be overwritten.  An optional third argument can change this.
" Weeding out entries from a Dictionary can be done with |filter()|: >
" 	:call filter(dict, 'v:val =~ "x"')
" This removes all entries from "dict" with a value not matching 'x'.
" Funcref
" Functions that can be used with a Dictionary: >
" 	:if has_key(dict, 'foo')	" TRUE if dict has entry with key "foo"
" 	:if empty(dict)			" TRUE if dict is empty
" 	:let l = len(dict)		" number of items in dict
" 	:let big = max(dict)		" maximum value in dict
" 	:let small = min(dict)		" minimum value in dict
" 	:let xs = count(dict, 'x')	" count nr of times 'x' appears in dict value
" 	:let s = string(dict)		" String representation of dict
" 	:call map(dict, '">> " . v:val')  " prepend ">> " to each item
" 	keys are coerced to strings in a dictionary
" &foldcolumn
" let Gbi=function('getbufinfo')
" echo Gbi()
" let foo=[[],[1,2],[3,4]]
" echo map(foo, 'reverse(v:val)')
" echo map(foo, {_,v -> reverse(v)})
" echo filter(foo, eval('{_,v -> !len(v)}'))
" let foo=[1,2]
" let X={_ -> 'k'}
" echo map(foo,X)
" function! Fn()
"   echo 'a'
" endfunction
" let Fn = { a,b -> a.b }
" let FFn = call(Fn, [1,2])
" echo FFn
" let Fn = { a,b -> a.b }
" let FFn = function(Fn,[1])
" echo FFn(2)
" pathogen -- inject paths in vim's runtimepath like PATH (use file#func
" functions)
" help tags
" help mark
" '. == normal gi
" tags
" Using tags makes it easier to jump to certain parts of your programs. First run ctags from the UNIX command line on your source files (e.g., ctags prog.c or ctags -R to recurse) to generate a "tags" file, then use these while editing your source files:
" :tag TAB            - list the known tags
" :tag function_name  - jump to that function
" ctrl-t   - goes to previous spot where you called :tag
" ctrl-]   - calls :tag on the word under the cursor        
" :ptag    - open tag in preview window (also ctrl-w })
" :pclose  - close preview window
" use <C-v>, <C-k> for recording normal/vim keybindings.
" use <C-e>, <C-y> for padded move.
" use <C-m> for newline in i-mode.
" surrounds: ys<select><x>, yS<select><x> (indents), cs<x><y>, ds<x>. Use open braces for padding (ys/yS commands), y{ss/SS} for selecting whole line.
" to create fixup! commit cf w.r.t. the faulty commit, then :Glog and ri on the faulty commit, replace pick -> fixup in front of the fixup commit.
" make sure both faulty and fixup commits are visible in the rebase window. 
" <C-{/}>, :buf <n> to move faster. K for definitions.=to indent.
" ce to amend staged hunks w/o changing previous commit (alt - ca). Prefer cc instead of C for committing staged hunks.
" Gedit# to go back from log menu to file. c{open/close} for commit window.
" folds: <n>zf,zo,zc,zd,zn,zN,fold,foldopen,foldclose,zE. {-x,+y} - relative selection.
" T,F to search backwards. setlocal for local settings.
" *map -- *noremap -- *unmap (im -- in -- iu, nm -- nn -- nun, vm -- vn -- vu). See map-modes for more.  
" au FileType fortran let maplocalleader="`" 
" use <buffer> in mappings to define those mappings for the current buffer only, e.g., nn <buffer><localleader>Q dd
" in case of similar mappings, vim goes with the more "specific" one (shadowing).
" g_ and _ for start/end of line.
" D to delete till end of line
" g; to jump back -- gi for last insert
" [{ for moving to enclosing scope's start
" <co> <ci> for bk,fw.
" q/
" highlight enclosing tags -- use v{i,a}t
" CTRL-] while the cursor is on a keyword (such as a function name) to jump to
" javascriptreact
" CAPSLOCK -> ESC
" zR zM
" zz
" c-o i mode
" *, #
" The ‘target’ branch is the one that is active when you run git merge. Or in
" other words, it’s the HEAD branch. The ‘merge’ branch is the one that is named
" in the git merge command.
" target == //2
" merge == //3
" For `git rebase -i master`, //2 is master, and //3 is the branch we were on
" before.
" map capslock to esc 
" systemctl start,status docker
