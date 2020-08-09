function clip_file
    if test (count $argv) -ge 3
        set -l tmp1 '^'
        set -l tmp2 '$'
        if test (count $argv) -eq 5
            set -l i $argv[4]
            while test $i -gt 0
                set tmp1 $tmp1"."
                set i (math "$i - 1")
            end
            set -l i $argv[5]
            while test $i -gt 0
                set tmp2 "."$tmp2
                set i (math "$i - 1")
            end
        end
        sed -n $argv[2],$argv[3]p $argv[1] | sed "1 s/$tmp1//" | sed '$ s/'$tmp2'//' | clip.exe
    end
end
