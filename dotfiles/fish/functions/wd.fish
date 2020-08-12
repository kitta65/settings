function wd
    if test -n "$WKDIR"
        cd "$WKDIR"
    else
        echo 'cannot find "$WKDIR"'
    end
end
