" ============================================================================
" Filename: autoload/fontcontroller/greenLadybug.vim
" Author: Fumiya Shibamata (@shibafumi)
" Last Change: 27-Sep-2019.
" ============================================================================

command! -count=0 -nargs=0  FontControlSizeUp call fontcontroller#greenLadybug#setFontSizeUp()
command! -count=0 -nargs=0  FontControlSizeDown call fontcontroller#greenLadybug#setFontSizeDown()
command! -nargs=0           FontControlSetDefault call fontcontroller#greenLadybug#setDefaultFormat()
command! -nargs=0           FontControlSetDefault call fontcontroller#greenLadybug#setDefaultFormat()

function! s:setOptions(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
        return 1
    endif
    return 0
endfunction

if !exists("g:FontController_Name_Default")
  let g:FontController_Name_Default = ""
endif

call s:setOptions("g:FontController_Cherset_Default","DEFAULT")
call s:setOptions("g:FontController_Quality_Default",'DEFAULT')
call s:setOptions("g:FontController_Highe_Default",'12')
call s:setOptions("g:FontController_Width_Default",'')
call s:setOptions("g:FontController_Bold_Default",'0')
call s:setOptions("g:FontController_Italic_Default",'0')
call s:setOptions("g:FontController_Under_Default",'0')
call s:setOptions("g:FontController_Strike_Default",'0')

" サイズズレの補正をするか(1:有効,0:無効)
call s:setOptions("g:FontController_zoom_correction",'1')
" 相対増加の倍率
call s:setOptions("g:FontController_zoom_agnification",'1.5')

