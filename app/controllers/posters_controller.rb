class PostersController < ApplicationController
  before_action :set_poster, only: [:show, :edit, :update, :close]
  before_action :set_categories, only: [:index, :search, :create]
  before_action :set_server
  before_action :set_servers
  INDEX_QUERY = "SELECT p.* FROM posters p INNER JOIN servers s ON p.server_id = s.id WHERE s.server = ? ORDER BY p.posted DESC"

  # 指定されたサーバの記事を全て取得する
  def index
    @server = params[:server]
    @posters = Poster.find_by_sql [INDEX_QUERY, @server]
  end

  # 指定された条件に該当する記事を検索する
  def search
    @server = params[:server]
    @category = params[:category]
    @keyword = params[:keyword]

    parameters = [@server]
    # まずは該当鯖の記事に限定
    where = "SELECT * FROM posters WHERE server_id = (SELECT id FROM servers WHERE server = ?) "
    # カテゴリが指定されているならそのカテゴリの記事に限定
    unless @category == "all" then
      where << "AND category_id = (SELECT id FROM categories WHERE category = ?)"
      parameters << @category
    end
    if @keyword == "all" then
      @keyword = nil
    # キーワードが指定されているときはそのキーワードを含む記事に限定
    else
      keywords = @keyword.split /\s/
      keywords.each_with_index do |k, idx|
        if idx == 0 then
          where << "AND "
        else
          where << "OR  "
        end
        where += "title LIKE ? OR content LIKE ?"
        parameters << "%" + k + "%"
        parameters << "%" + k + "%"
      end
    end
    @posters = Poster.find_by_sql [where] + parameters
    render "index"
  end

  # 新規投稿画面
  # 区分表示のために区分を検索しておいてやる（ただし検索専用である"全て"は除く）
  def new
    @categories = Category.where.not category: "all"
  end


  # before_actionのset_posterだけで完結する
  def show
  end

  # POST /posters
  # POST /posters.json
  def create
    @poster = Poster.new(poster_params)
    @poster.posted = DateTime.now
    @poster.server_id = Server.find_by(server: params[:server]).id
    @poster.category_id = Category.find_by(category: params[:category]).id
    p @poster
    if @poster.save
      redirect_to action: "index"
    else
      @notice = "入力内容を確認してください"
      render "posters/new"
    end
  end

  # PATCH/PUT /posters/1
  # PATCH/PUT /posters/1.json
  def update
    respond_to do |format|
      if @poster.update(poster_params)
        format.html { redirect_to @poster, notice: 'Poster was successfully updated.' }
        format.json { render :show, status: :ok, location: @poster }
      else
        format.html { render :edit }
        format.json { render json: @poster.errors, status: :unprocessable_entity }
      end
    end
  end

  # 記事を終了する
  def close
    input_key = params[:close_key]
    valid_key = Poster.find(params[:id]).close_key
    p "before if"
    unless input_key == valid_key then
      @notice = "終了キーが正しくありません！"
    else
      @poster.closed = true
      if @poster.save then
        @notice = "記事を終了しました"
      end
    end    
    render "posters/show"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poster
      @poster = Poster.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end

    def set_server
      @server = params[:server]
    end

    def set_servers
      @servers = Server.all.order id: :asc
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poster_params
      params.require(:poster).permit(:category, :title, :contributor, :uid, :posted, :content, :delete_key, :closed, :previews)
    end

end
