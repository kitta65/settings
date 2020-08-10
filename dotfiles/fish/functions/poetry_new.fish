function poetry_new
    if test (count $argv) -ne 0
        poetry new $argv
        cd $argv
        rm -rf tests
        rm -rf $argv
        rm README.rst
        echo /.venv/ > .gitignore
        touch README.md
        poetry install
        git init
        cd ..
    else
        echo 'argv error'
    end
end
