function wd
    if test -n "$wkdir"
        cd "$wkdir"
    else
        echo 'cannot find "$wkdir"'
    end
end
