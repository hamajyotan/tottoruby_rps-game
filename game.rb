#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require

class Even < RuntimeError; end

class Game
  N = 5

  def call
    p1 = choice_player_type('プレイヤー1')
    p2 = choice_player_type('プレイヤー2')

    (1..N).each do |i|
      delimiter
      puts "#{i} 回目！"
      puts 'じゃんけん。。。'

      winner = match(p1, p2)
      puts "#{winner.name} さんの勝ち！"
      winner.win
    end

    delimiter
    puts "#{p1.name} さん、 #{p1.win_count} 回勝利！"
    puts "#{p2.name} さん、 #{p2.win_count} 回勝利！"

    if p1.win_count > p2.win_count
      puts "#{p1.name} さんおめでとう！ 💐💐💐"
    elsif p2.win_count > p1.win_count
      puts "#{p2.name} さんおめでとう！ 💐💐💐"
    else
      puts "ひきわけ！！"
    end
  end

  private

  def choice_player_type(name)
    players = TottorubyRps::Player.players

    choiced = nil
    until choiced
      delimiter
      puts "#{name} を選ぶぽよ"
      players.each.with_index do |player, index|
        puts "\t#{index} : #{player}"
      end
      print '> '
      input = gets.to_i
      choiced = players[input]
    end
    puts
    choiced.new(name)
  end

  def match(player_1, player_2)
    g1 = player_1.shoot
    g2 = player_2.shoot

    puts "#{player_1.name} さん / #{g1.name}"
    puts "#{player_2.name} さん / #{g2.name}"

    result = g1.judge(g2)
    if result.positive?
      player_1
    elsif result.negative?
      player_2
    else
      raise Even
    end
  rescue Even
    puts 'あいこで。。。。'
    retry
  end

  def delimiter = puts '*' * 80
end

# TottorubyRps

Game.new.call

