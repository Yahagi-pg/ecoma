class PosNController < ApplicationController
  def posters
  	names = ["ダークフェザー", "バルル", "ローキー", "清姫", "玉藻", "メフィストフェレス", "エリーゼ", "リーリエ", "アルティ", "ドラッキー"]
  	100.times do |i|
  		idx = i + 1
  		p = Poster.new
  		p.category_id = rand(3).to_i + 1
  		p.server_id = rand(4).to_i + 1
  		name = names[rand(names.size).to_i]
  		p.title = name
  		p.content = name
  		p.id = idx
  		p.contributor = "てすたー" + idx.to_s
  		p.posted = rand(DateTime.parse("2000/1/1") .. DateTime.parse("2014/12/31"))
  		p.closed = i%2 == 0
  		p.close_key = rand(9999).to_s
  		p.save
  	end
  end

  def replies
  	300.times do |i|
  		r = Reply.new
  		r.id = i + 1
  		r.poster_id = rand(100) + 1
  		r.posted = rand(DateTime.parse("2000/1/1") .. DateTime.parse("2014/12/31"))
  		r.contributor = "てすたー" + i.to_s
  		r.content = "れぷらい" + i.to_s
  		r.save
  	end
  end
end
