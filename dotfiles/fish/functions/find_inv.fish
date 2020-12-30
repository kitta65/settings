function find_inv
    set -l p (pwd)
    set -l flg 1
    set -l target $argv

    while ! test -z $p
        if test (count (find $p -maxdepth 1 -name $target)) -gt 0
            set flg 0
            break
        end
        set p (string replace -r '/[^/]*$' '' $p) # `-l` is not needed
    end

    if test $flg = 0
        echo "$p/$target"
        return $flg
    else
        return $flg
    end
end
