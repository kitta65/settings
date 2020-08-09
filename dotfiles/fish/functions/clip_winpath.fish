function clip_winpath
    string replace "/mnt/c" "C:" $argv | clip.exe
end
