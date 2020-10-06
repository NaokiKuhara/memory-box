class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @posts = Post.all
  end

  def show
    # @post = Post.find(params[:id])
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      title: params[:title],
      body: params[:body],
      image_name: "photo.jpg"
    )
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path(@post), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user.id != current_user.id
      flash[:notice] = "不正なアクセスです"
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:title]
    @post.body = params[:body]
    if params[:image]
      @post.image_name = "#{@post.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@post.image_name}", image.read)
    end
    if @post.save
      redirect_to post_path(@post), notice: "更新に成功しました"
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

end
