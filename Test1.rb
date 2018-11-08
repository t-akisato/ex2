# -*- coding: utf-8 -*-
# Test用プログラム ひたすら四方をsearch（調べる）

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("テスト1") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない

loop do # 無限ループ
    #----- ここから -----

    values = target.getReady
    if values[0] == 0 # 先頭が0になったら終了
        break
    end
    values = target.searchUp
    if values[0] == 0
        break
    end
    values = target.getReady
    if values[0] == 0
        break
    end
    values = target.searchRight
    if values[0] == 0
        break
    end
    values = target.getReady
    if values[0] == 0
        break
    end
    values = target.searchDown
    if values[0] == 0
        break
    end
    values = target.getReady
    if values[0] == 0
        break
    end
    values = target.searchLeft
    if values[0] == 0
        break
    end

    #----- ここまで -----
end

target.close # ソケットを閉じる
