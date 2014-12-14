class CommentsController < ApplicationController

	def create
		@note = Note.find(params[:comment][:note_id])
		if user_signed_in?
			params[:comment] = params[:comment].merge(user_id: current_user.id)
		end
		@comment = Comment.new(comment_params)
		respond_to do |format|
			if @comment.save
				format.html { redirect_to @note }
				format.js
			else
				format.html { redirect_to root_path }
				format.js { render :template => 'error.js.erb' }
			end
		end
	end

	private
	def comment_params
		params.require(:comment).permit(:desc, :user_id, :note_id)
	end
end
