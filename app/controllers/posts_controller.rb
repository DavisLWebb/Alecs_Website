class PostsController < ApplicationController

  respond_to :html, :json
  before_action :load_post, :only => [:show]

  def index
    @posts = Post.paginate(:page => params[:page])
    respond_with @posts
  end

  def show
    respond_with @post
  end

private

  def load_post
    @post = Post.where(:id => params[:id]).first
    if @post.blank?
      raise Spud::NotFoundError.new(:item => 'post')
      return false
    end
  end

end
