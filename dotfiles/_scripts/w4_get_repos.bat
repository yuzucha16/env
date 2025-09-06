@echo off
setlocal EnableExtensions EnableDelayedExpansion

ghq get yuzucha16/env

rem c++ samples
ghq get bareflank/static_interface_pattern
ghq get skypjack/entt
ghq get microsoft/proxy
ghq get foonathan/type_safe
ghq get mpusz/mp-units
ghq get cpp-best-practices/gui_starter_template

rem dev settings
rem ghq get yuzuch16/env
rem ghq get yuzuch16/adv360-pro-zmk
rem ghq get yuzuch16/dotfiles

rem Autosar samples
ghq get inniyah/arccore

:END
pause
endlocal
