function csv2dic
    if which mecab
        /usr/lib/mecab/mecab-dict-index -d $SYSTEM_DIC -u $USER_DIC -f utf-8 -t utf-8 $argv
    else
        echo 'installation error `mecab`'
    end
end
