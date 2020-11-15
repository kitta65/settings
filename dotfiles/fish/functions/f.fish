function f
    # when searching for python files, `f "*.py"`.
    find . -iname $argv[1] -print
end
