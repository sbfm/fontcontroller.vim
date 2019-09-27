" =============================================================================
" Filename: autoload/fontcontroller/greenLadybug.vim
" Author: Fumiya Shibamata (@shibafumi)
" Last Change: 27-Sep-2019.
" =============================================================================

if exists("g:loaded_fontcontroller_autoload")
    finish
endif
let g:loaded_fontcontroller_autoload = 1

function! fontcontroller#greenLadybug#version()
    return '1.0.0'
endfunction

"----------------------------
" 現在のフォント設定を取得する
"----------------------------
function! s:getFontOptions()
  " フォント情報の取得
  if empty(&guifontset)
    redir => s:nowGUIFont
      sil set guifont
    redir END
  else
    redir => s:nowGUIFont
      sil set guifontset
    redir END
  endif
  
  " 各設定地を確認
  let s:FontController_Name = matchstr(s:nowGUIFont, '=¥zs[^:]*¥ze¥(:.*¥|¥)$')
  let s:FontController_Highe = str2float(matchstr(s:nowGUIFont, ':h¥zs[^:]*¥ze¥(:.*¥|¥)$'))
  let s:FontController_Width = str2float(matchstr(s:nowGUIFont, ':w¥zs[^:]*¥ze¥(:.*¥|¥)$'))
  let s:FontController_Cherset = matchstr(s:nowGUIFont, ':c¥zs[^:]*¥ze¥(:.*¥|¥)$')
  let s:FontController_Quality = matchstr(s:nowGUIFont, ':q¥zs[^:]*¥ze¥(:.*¥|¥)$')
  let s:FontController_Bold = strlen(matchstr(s:nowGUIFont, ':¥zsb¥ze¥(:.*¥|¥)$'))
  let s:FontController_Italic = strlen(matchstr(s:nowGUIFont, ':¥zsi¥ze¥(:.*¥|¥)$'))
  let s:FontController_Under = strlen(matchstr(s:nowGUIFont, ':¥zsu¥ze¥(:.*¥|¥)$'))
  let s:FontController_Strike = strlen(matchstr(s:nowGUIFont, ':¥zss¥ze¥(:.*¥|¥)$'))
endfunction

"----------------------------
" 現在の設定を反映する
"----------------------------
function! s:setFontOptions()
  let s:FontController_setting = s:FontController_Name
  
  if !empty(s:FontController_Highe)
    let s:FontController_setting = s:FontController_setting . ":h" . printf("%f",s:FontController_Highe)
  endif
  if !empty(s:FontController_Width)
    let s:FontController_setting = s:FontController_setting . ":w" . printf("%f",s:FontController_Width)
  endif
  if s:FontController_Cherset!=""
    let s:FontController_setting = s:FontController_setting . ":c" . s:FontController_Cherset
  endif
  if s:FontController_Quality!=""
    let s:FontController_setting = s:FontController_setting . ":q" . s:FontController_Quality
  endif
  if s:FontController_Bold
    let s:FontController_setting = s:FontController_setting . ":b"
  endif
  if s:FontController_Italic
    let s:FontController_setting = s:FontController_setting . ":i"
  endif
  if s:FontController_Under
    let s:FontController_setting = s:FontController_setting . ":u"
  endif
  if s:FontController_Strike
    let s:FontController_setting = s:FontController_setting . ":s"
  endif
  
  " 設定値の反映
  let s:optionsettingFlag = 0
  
  if !empty(&guifontset)
    execute "set guifontset=" . s:FontController_setting
    let s:optionsettingFlag = 1
  endif
  if !empty(&guifontwide)
    execute "set guifontwide=" . s:FontController_setting
    let s:optionsettingFlag = 1
  endif
  if (!empty(&guifont) || !s:optionsettingFlag)
    execute "set guifont=" . s:FontController_setting
  endif
endfunction

" --------------------------------
" フォントサイズを大きくする
" --------------------------------
function! fontcontroller#greenLadybug#setFontSizeUp()
  " 現在の設定値の取得
  call s:getFontOptions()
  
  " サイズ指定がない場合、デフォルトを設定
  if empty(s:FontController_Highe)
    let s:FontController_Highe = str2float(g:FontController_Highe_Default)
  endif
  
  " カウント(繰り返し回数)の取得
  let s:fontsizecount = v:count
  if v:count == 0
    let s:fontsizecount = 1
  endif
  
  " 現在のサイズから修正後のサイズを計算
  let s:FontController_Highe = s:FontController_Highe + (s:fontsizecount * g:FontController_zoom_agnification)
  
  " サイズがずれている時の補正有効時に補正
  if g:FontController_zoom_correction
     let s:FontController_Highe = (trunc(s:FontController_Highe / g:FontController_zoom_agnification) * g:FontController_zoom_agnification)
  endif
  
  call s:setFontOptions()
endfunction

" --------------------------------
" フォントサイズを小さくする
" --------------------------------
function! fontcontroller#greenLadybug#setFontSizeDown()
  " 現在の設定値の取得
  call s:getFontOptions()
  
  " サイズ指定がない場合、デフォルトを設定
  if empty(s:FontController_Highe)
    let s:FontController_Highe = str2float(g:FontController_Highe_Default)
  endif
  
  " カウント(繰り返し回数)の取得
  let s:fontsizecount = v:count
  if v:count == 0
    let s:fontsizecount = 1
  endif
  
  " 現在のサイズから修正後のサイズを計算
  let s:FontController_Highe = s:FontController_Highe - (s:fontsizecount * g:FontController_zoom_agnification)
  
  " サイズがずれている時の補正有効時に補正
  if g:FontController_zoom_correction
    let s:FontController_Highe = (trunc((s:FontController_Highe + g:FontController_zoom_agnification - 0.000001) / g:FontController_zoom_agnification) * g:FontController_zoom_agnification)
  endif
  
  call s:setFontOptions()
endfun

" --------------------------------
" フォントサイズを指定する
" --------------------------------
function! fontcontroller#greenLadybug#setFontSize(size)
  " 現在の設定値の取得
  call s:getFontOptions()
  let s:FontController_Highe = a:size
  call s:setFontOptions()
endfun

" --------------------------------
" 基本設定を指定する
" --------------------------------
function! fontcontroller#greenLadybug#setDefaultFormat()
  " 現在の設定値の取得
  call s:getFontOptions()
  
  let s:FontController_Cherset = g:FontController_Cherset_Default
  let s:FontController_Quality = g:FontController_Quality_Default
  let s:FontController_Highe = g:FontController_Highe_Default 
  let s:FontController_Width = g:FontController_Width_Default
  let s:FontController_Bold = g:FontController_Bold_Default
  let s:FontController_Italic = g:FontController_Italic_Default
  let s:FontController_Under = g:FontController_Under_Default
  let s:FontController_Strike = g:FontController_Strike_Default
  
  call s:setFontOptions()
endfun

" --------------------------------
" 基本設定を指定する
" --------------------------------
function! fontcontroller#greenLadybug#setDefaultFormat()

endfun

