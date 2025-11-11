require 'csv'

loop do
  puts "------メモ作成---"
  puts "1: 新規ファイル作成"
  puts "2: 既存ファイル編集（上書き or 追加）"
  puts "3: 終了"
  print "番号を入力してください: "

  choice = gets
  break if choice.nil? 
  choice = choice.chomp

  case choice
  when "1"
    # --- 新規作成 ---
    print "新しいCSVファイル名を入力してください: "
    filename = gets
    break if filename.nil?
    filename = filename.chomp
    filename += ".csv" unless filename.end_with?(".csv")

    if File.exist?(filename)
      print "ファイルは既に存在します。上書きしますか？(y/n): "
      answer = gets
      break if answer.nil?
      answer = answer.chomp.downcase
      if answer != "y"
        puts "作成を中止しました。"
        next
      end
    end

    puts "#{filename} を作成しました。内容を入力してください（Enterで改行、Ctrl+Dで保存）:"
    memo_text = ""
    while line = $stdin.gets
      memo_text << line
    end
    memo_text = memo_text.chomp  

    # 空でも保存できるように
    CSV.open(filename, "w", quote_char: "") do |csv|
      csv << [memo_text]
    end

    $stdin.reopen('/dev/tty')

  when "2"
    # --- 既存ファイル編集 ---
    print "編集するCSVファイル名を入力してください: "
    filename = gets
    break if filename.nil?
    filename = filename.chomp
    filename += ".csv" unless filename.end_with?(".csv")

    unless File.exist?(filename)
      puts "ファイルが存在しません。"
      next
    end

    rows = CSV.read(filename, encoding: "UTF-8")
    puts "\n現在の内容:"
    puts "----------------------"
    rows.each_with_index do |row, i|
      puts "#{i + 1}: #{row[0]}"
    end
    puts "#{rows.size + 1}: （新しい行を追加）"
    puts "#{rows.size + 2}: メニューに戻る"
    puts "----------------------"

    print "編集したい行番号を入力してください: "
    input = gets
    break if input.nil?
    line_num = input.to_i

    # メニューに戻る処理
    if line_num == rows.size + 2
                puts "メニューに戻ります。"
      next
    elsif line_num < 1 || line_num > rows.size + 1
                puts "無効な行番号です。メニューに戻ります。"
      next
    end

    if line_num == rows.size + 1
      puts "\n【追加モード】"
    else
      puts "\n現在の内容: #{rows[line_num - 1][0]}"
          puts "【上書きモード】"
    end

       puts "新しい内容を入力してください（Enterで改行、Ctrl+Dで確定）:"
    new_text = ""
    while line = $stdin.gets
      new_text << line
    end
    new_text = new_text.chomp  # 空でもOK

    if line_num == rows.size + 1
      rows << [new_text]
      puts "→ 行を追加しました（行番号 #{rows.size}）。"
    else
      rows[line_num - 1][0] = new_text
                   puts "→ 行 #{line_num} を更新しました。"
    end

    
         CSV.open(filename, "w", quote_char: "") do |csv|
      rows.each { |r| csv << r }
    end

    $stdin.reopen('/dev/tty')

  when "3"
    puts "終了します。"
    break

  else
    puts "無効な入力です。もう一度入力してください。"
  end

  puts "\n--------------------------------\n\n"
end
