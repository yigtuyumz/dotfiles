set colorcolumn=80
setlocal shiftwidth=4 softtabstop=4 expandtab
highlight ColorColumn ctermbg=235


syntax match VeryImportantComment / \{0,\}\/\/!.*/
highlight VeryImportantComment ctermfg=160 ctermbg=none cterm=none

syntax match EmphasisedCommentLine / \{0,\}\/\/\~.*/
highlight EmphasisedCommentLine ctermfg=45 ctermbg=none cterm=italic

syntax match TODOCommentLine / \{0,\}\/\/TODO.*/
highlight TODOCommentLine ctermfg=172 ctermbg=none cterm=bold

syntax match UnderlineCommentLine /\S\@<!\/\/>.*/
highlight UnderlineCommentLine ctermfg=34 ctermbg=none cterm=underline

syntax match ColorVariant / \{0,\}\/\/!!.*/
highlight ColorVariant ctermfg=220 ctermbg=none cterm=none
