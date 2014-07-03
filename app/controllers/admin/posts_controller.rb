class Admin::PostsController < Admin::ApplicationController

  before_action :load_post, :only => [:show, :edit, :update, :destroy]
  belongs_to_spud_app :posts
  add_breadcrumb "Posts", :admin_posts_path

  def index
    @posts = Post.paginate(:page => params[:page])
    respond_with @posts
  end

  def show
    respond_with @posts
  end

  def new
    @post = Post.new
    respond_with @post
  end

  def create
    @post = Post.new(post_params)
    flash[:notice] = 'Post created successfully' if @post.save
    respond_with @post, :location => admin_posts_path
  end

  def edit
    respond_with @post
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = 'Post updated successfully'
    end
    respond_with @post, :location => admin_posts_path
  end

  def destroy
    flash[:notice] = 'Post deleted successfully' if @post.destroy
    respond_with @post, :location => admin_posts_path
  end

private

  def load_post
    @post = Post.where(:id => params[:id]).first
    if @post.blank?
      flash[:error] = "Could not find the requested Post"
      redirect_to admin_posts_path
      return false
    end
  end

  def post_params
    params.require(:post).permit(:content)
  end

end
