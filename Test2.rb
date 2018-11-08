# -*- coding: utf-8 -*-
# Test用プログラム 壁にそって進む

require 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# サーバに接続
target = CHaserConnect.new("テスト②") # この名前を4文字までで変更する

values = Array.new(10) # 書き換えない
mode = 1

loop do # 無限ループ
  #----- ここから -----
  values = target.getReady # 準備信号を送り制御情報と周囲情報を取得
  if values[0] == 0        # 制御情報が0なら終了
    break
  end
  
  # modeの値で分岐する
  if mode == 1
    if values[8] != 2           # 下が壁でないなら
      values = target.walkDown  # 下に進む
    else                        # 下が壁なら
      values = target.walkRight # 右に進む
      mode = 2
    end
  elsif mode == 2
    if values[6] != 2           # 右が壁でないなら
      values = target.walkRight # 右に進む
    else                        # 右が壁なら
      values = target.walkUp    # 上に進む
      mode = 3
    end
  elsif mode == 3
    if values[2] != 2           # 上が壁でないなら
      values = target.walkUp    # 上に進む
    else                        # 上が壁なら
      values = target.walkLeft  # 左に進む
      mode = 4
    end
  elsif mode == 4
    if values[4] != 2           # 左が壁でないなら
      values = target.walkLeft  # 左に進む
    else                        # 左が壁なら
      values = target.walkDown  # 下に進む
      mode = 1
    end
  end

  if values[0] == 0 # 制御情報が0なら終了
   break
  end
  #----- ここまで -----
end

target.close # ソケットを閉じる
