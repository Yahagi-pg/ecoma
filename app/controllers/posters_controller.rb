class PostersController < ApplicationController
  before_action :set_poster, only: [:show, :edit, :update, :destroy]
  INDEX_QUERY = "SELECT p.* FROM posters p INNER JOIN servers s ON p.server_id = s.id WHERE s.server = ?"

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
    # キーワードが指定されているときはそのキーワードを含む記事に限定
    unless @keyword == "all" then
      keywords = @keyword.split /\s/
      keywords.each_with_index do |c, idx|
        if idx == 0 then
          where << "AND "
        else
          where << "OR  "
        end
        where += "title LIKE ? OR content LIKE ?"
        parameters << "%" + c + "%"
        parameters << "%" + c + "%"
      end
    end
    @posters = Poster.find_by_sql [where] + parameters
    render "index"
  end

  # before_actionのset_posterだけで完結する
  def show
  end

  # POST /posters
  # POST /posters.json
  def create
    @poster = Poster.new(poster_params)

    respond_to do |format|
      if @poster.save
        format.html { redirect_to @poster, notice: 'Poster was successfully created.' }
        format.json { render :show, status: :created, location: @poster }
      else
        format.html { render :new }
        format.json { render json: @poster.errors, status: :unprocessable_entity }
      end
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

  # DELETE /posters/1
  # DELETE /posters/1.json
  def destroy
    @poster.destroy
    respond_to do |format|
      format.html { redirect_to posters_url, notice: 'Poster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poster
      @poster = Poster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def poster_params
      params.require(:poster).permit(:category, :title, :contributor, :uid, :posted, :content, :delete_key, :closed, :previews)
    end
end
