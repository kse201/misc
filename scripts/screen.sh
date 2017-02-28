#! /bin/bash

# セッション名を設定
s_name='foo'

user="vagrant"

# 接続先ホストリスト
hosts=( \
        'host1' \
        'host2'
      )

# window名（今回はホスト名の短縮名として設定）
w_names=( \
         'h1' \
         'h2'
        )

# mngrだけは0番windowに特別に設定
echo "screen[0]: mngr"
screen -d -m -S $s_name -t 'mngr'

i=1
while [ $i -le ${#hosts[@]} ]
do
    wid=$i
    idx=$((i - 1))
    echo "screen[$wid]: ${hosts[$idx]}"
    screen -X -S "${s_name}" screen -t "${w_names[$idx]}" "${wid}" ssh "${hosts[$idx]}"
    i=$((i + 1))
done

screen -d -r "${s_name}" -p 0
