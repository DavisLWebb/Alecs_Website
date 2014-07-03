class StaticPagesController < ApplicationController



  def home
    @posts = Post.all.to_a
  end

  def help
  end

  def about
  end

  def gallery
  end

end
