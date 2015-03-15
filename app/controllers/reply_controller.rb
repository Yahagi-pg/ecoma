class ReplyController < ApplicationController
	before_action :set_poster, only: [:post]

	# 送信されてきたreplyを保存する
	def create
		@server = params[:server]
		reply = Reply.new reply_params
		reply.poster_id = params[:id]
		reply.posted = DateTime.now

		if reply.save then
			redirect_to "/posters/#{@server}/#{params[:id]}"
		else
			
		end
	end

	# IDに該当する記事を取得する
	def set_poster
		@poster = Poster.find params[:id]
	end

	# replyのためのパラメータをリクエストから取得する
	def reply_params
		params.require(:reply).permit(:contributor, :content, :poster_id)
	end
end
