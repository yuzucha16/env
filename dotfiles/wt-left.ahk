#Requires AutoHotkey v2.0

; Windows Terminal を起動
Run("wt.exe")

; Terminal がアクティブになるのを待つ
WinWaitActive("ahk_exe WindowsTerminal.exe")

; 画面サイズ取得
screenW := A_ScreenWidth
screenH := A_ScreenHeight

; 左半分に配置
WinMove(0, 0, screenW/2, screenH, "ahk_exe WindowsTerminal.exe")
