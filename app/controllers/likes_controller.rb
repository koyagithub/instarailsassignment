class LikesController < ApplicationController
  before_action :set_variables

  def like
    like = current_user.likes.new(micropost_id: @micropost.id)
    like.save
  end

  def unlike
    like = current_user.likes.find_by(micropost_id: @micropost.id)
    like.destroy
  end

  private

  def set_variables
    @micropost = Micropost.find(params[:micropost_id])
    @id_name = "#like-link-#{@micropost.id}"
  end

end
