require 'test_helper'

class PostersControllerTest < ActionController::TestCase
  setup do
    @poster = posters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create poster" do
    assert_difference('Poster.count') do
      post :create, poster: { category: @poster.category, closed: @poster.closed, content: @poster.content, contributor: @poster.contributor, delete_key: @poster.delete_key, posted: @poster.posted, previews: @poster.previews, title: @poster.title, uid: @poster.uid }
    end

    assert_redirected_to poster_path(assigns(:poster))
  end

  test "should show poster" do
    get :show, id: @poster
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @poster
    assert_response :success
  end

  test "should update poster" do
    patch :update, id: @poster, poster: { category: @poster.category, closed: @poster.closed, content: @poster.content, contributor: @poster.contributor, delete_key: @poster.delete_key, posted: @poster.posted, previews: @poster.previews, title: @poster.title, uid: @poster.uid }
    assert_redirected_to poster_path(assigns(:poster))
  end

  test "should destroy poster" do
    assert_difference('Poster.count', -1) do
      delete :destroy, id: @poster
    end

    assert_redirected_to posters_path
  end
end
