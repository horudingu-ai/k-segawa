#定義　(じゃんけん、あっち向いてホイ_方向)
HAND = { 1 => 'グー', 2 => 'チョキ', 3 => 'パー' }
DIRECTION = { 1 => '上', 2 => '右', 3 => '下', 4 => '左' }


      def prompt(message)
          print message
   end
   
  #じゃんけんする過程
    def get_player_hand
  loop do            #ループ
     puts "\nじゃんけん......"
     puts "1: (グー)  2: (チョキ)  3: (パー)  0: 戦わない"
    prompt "> "
          input = STDIN.gets
                 return nil if input.nil?    # Ctrl+D 等で終了
    input = input.chomp
    if input =~ /\A[0-3]\z/     #0123以外は拒否マン
      num = input.to_i   #整数変換
    
    #0を押して終了する時  
          if num == 0
             puts "あっち向いてホイを終了します。"
             exit
      end
      
      
      return num
    else
      puts "0~3の数字を入力してください"
         end
                 end
          end

  def get_player_direction(role)
    loop do
        puts "\n#{role}：あっち向いて~"
        puts "1: 上 2: 右 3: 下 4: 左"
    prompt "> "
    input = STDIN.gets
    return nil if input.nil?
    input = input.chomp
    if input =~ /\A[1-4]\z/
      return input.to_i
    else
      puts "不正な値です。1~4の数字を入力してください。"
      end
    end
        end
# 勝敗判定（プレイヤーhand, 相手hand）
# return :win, :lose, :draw
def judge(player, enemy)
  return :draw if player == enemy  #Aiko
  # グー(1) > チョキ(2), チョキ(2) > パー(3), パー(3) > グー(1)
         if (player == 1 && enemy == 2) ||     #勝利条件
            (player == 2 && enemy == 3) ||
            (player == 3 && enemy == 1)
    :win
  else
    :lose
  end
end

puts "=== じゃんけん + あっち向いてホイ ==="

loop do
  #  じゃんけんで勝敗を決める
   player_hand = get_player_hand
   break if player_hand.nil? 
   enemy_hand = rand(1..3)
          puts "あなた: #{HAND[player_hand]}  /  相手: #{HAND[enemy_hand]}"

          #Aiko
result = judge(player_hand, enemy_hand)
   if result == :draw
    puts "あいこで......"
next
    end

   #じゃんけん勝ち
  if result == :win
    puts "じゃんけんの勝者: あなた"
    # あっち向いてホイ：勝者（あなた）が指を差す、敗者（相手）が顔を向ける
    winner_role = 'あなた(指をさす)'
    loser_role = '相手(顔を向ける)'

# 勝者はplayerなのでplayerの方向入力を受け取る
    winner_dir = get_player_direction('あなた（指す方向）')
    #コンピュータはランダムに向く
    loser_dir = rand(1..4)
    puts "あなたが指を指した方向: #{DIRECTION[winner_dir]}"
    puts "相手が顔を向いた方向: #{DIRECTION[loser_dir]}"

    if winner_dir == loser_dir
    puts "\nあっち向いてホイの方向が一致しました。"
    puts "winner: あなた "
    break
    else
      puts "方向が一致しませんでした。じゃんけんからやり直します。"
      next
    end
#player負け
  else # result == :lose
    puts "じゃんけんの勝者: 相手"
        # あっち向いてホイ：勝者（相手）が指を差す、敗者（あなた）が顔を向ける
         # 勝者（コンピュータ）はランダムに指を差す
    winner_dir = rand(1..4)
 # 敗者（あなた）は入力で顔を向く
    loser_dir = get_player_direction('あなた（顔を向ける方向）')

         puts "相手が指を指した方向: #{DIRECTION[winner_dir]}"
         puts "あなたが顔を向いた方向: #{DIRECTION[loser_dir]}"

    if winner_dir == loser_dir
         puts "\nあっち向いてホイ 方向が一致しました。"
          puts "最終勝者: 相手（あなたの負け）"
      break
    else
      puts "方向が一致しませんでした。じゃんけんからやり直します。"
      next
    end
  end
end

puts "あっち向いてホイを終了します。"
