# -*- coding: utf-8 -*-

# ex2a
#
# ランダムな方向にPUTかLOOKかSEARCHする。
# 上下左右に敵が来たらPUTする。

require_relative 'CHaserConnect.rb' # CHaserConnect.rbを読み込む Windows

# 定数
# 方向
D_UP = 2
D_LEFT = 4
D_RIGHT = 6
D_DOWN = 8
Directions = [D_UP, D_LEFT, D_RIGHT, D_DOWN]
# アクション
A_PUT = 1
A_WALK= 2
A_LOOK = 3
A_SEARCH = 4
# マップ
M_FLOOR = 0
M_CHARA = 1
M_BLOCK = 2
M_ITEM = 3

# サーバに接続
@target = CHaserConnect.new("ex2a") # この名前を4文字までで変更する

@values = Array.new(10) # getReady の結果を受ける。
@results = Array.new(10) # アクションの結果を受ける。

# 初期化
def init
    @values = @target.getReady
end

# dir の方向に act のアクションを実行して getReady する。
# 上下左右に敵がいたら PUT 。
def doAction(dir, act)
    case act
    when A_WALK
        case dir
        when D_UP
            @results = @target.walkUp
        when D_DOWN
            @results = @target.walkDown
        when D_RIGHT
            @results = @target.walkRight
        when D_LEFT
            @results = @target.walkLeft
        end
    when A_LOOK
        case dir
        when D_UP
            @results = @target.lookUp
        when D_DOWN
            @results = @target.lookDown
        when D_RIGHT
            @results = @target.lookRight
        when D_LEFT
            @results = @target.lookLeft
        end
    when A_PUT
        case dir
        when D_UP
            @results = @target.putUp
        when D_DOWN
            @results = @target.putDown
        when D_RIGHT
            @results = @target.putRight
        when D_LEFT
            @results = @target.putLeft
        end
    when A_SEARCH
        case dir
        when D_UP
            @results = @target.searchUp
        when D_DOWN
            @results = @target.searchDown
        when D_RIGHT
            @results = @target.searchRight
        when D_LEFT
            @results = @target.searchLeft
        end
    end

    if @results[0] == 0 then
        exit
    end

    @values = @target.getReady
    if @values[0] == 0 then
        exit
    end

    # 上下左右に敵がいたら PUT
    [D_UP,D_DOWN,D_RIGHT,D_LEFT].each do |d|
        if @values[d] == M_CHARA then
            doAction(d, A_PUT)
        end
    end
end

#======================================================

init # 初期化
# 初めの向き
direction = Directions.sample

loop do # 無限ループ
    #----- ここから -----

    if @values[direction] == M_BLOCK then # 向いてる方がブロックなら
        not_block = []
        Directions.each do | dir |
            if @values[dir] != M_BLOCK then
                not_block << dir
            end
        end
        direction = not_block.sample
    end

    doAction(direction, A_WALK)

    #----- ここまで -----
end

@target.close # ソケットを閉じる
