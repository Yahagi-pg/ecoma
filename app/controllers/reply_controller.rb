class ReplyController < ApplicationController
	before_action :set_poster, only: [:post]

	# 送信されてきたreplyを保存する
	def create
		@server = params[:server]
		reply = Reply.new reply_params
		reply.posted = DateTime.now
		reply.poster_id = @poster.id

		if reply.save then
			format.html {redirect_to @poster, notice: "投稿完了"}
			format.json {render action: "show", status: :created, location: @poster}
		else
			format.html {render action: "show"}
			format.json {render json: @poster.errors, status: :unprocessable_entity}
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
