class PostsController < ApplicationController
<<<<<<< HEAD
  before_action :authenticate_user!, only: %i[create destroy]
  load_and_authorize_resource
=======
  before_action :authenticate_user!

>>>>>>> 67a78bbfcbc12753475b18de3f640ed9a9164892
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(comments: :author)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @author = User.find(params[:user_id])
    @post = @author.posts.new(post_params)

    if @post.save
      redirect_to user_path(id: @post.author_id), notice: 'Post was successfully created'

    else
      render :new, alert: 'Error ccurred while creating the post'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @author = @post.author
    @author.decrement!(:post_counter)
    @post.destroy!
    redirect_to user_posts_path(id: @author.id), notice: 'Post was deleted successfully!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
