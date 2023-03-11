vim.cmd[[
" :h popup-menu
" Right click to invoke commands I have habbit of forgetting the name of.
" Just list all tools for eye.
aunmenu PopUp
nnoremenu PopUp.Colorizer\ Toggle :ColorizerToggle<cr>
nnoremenu PopUp.Mundo\ Toggle :echo "TODO install this"<cr>
" Some for visual range
vnoremenu PopUp.Prettify\ SQL :echo "TODO this"<cr>
vnoremenu PopUp.Prettify\ JSON :echo "TODO implement this"<cr>
vnoremenu PopUp.Eval\ as\ LuaScript :echo "TODO implement this"<cr>
vnoremenu PopUp.Eval\ as\ VimScript :echo "TODO implement this"<cr>
]]
