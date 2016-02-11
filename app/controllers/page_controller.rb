class PageController < ApplicationController
	def image
  		@page= Page.find(params[:id])
  	end
  
  	def like
  		@page = Page.find(params[:id])
  		if current_user.voted_for? @page
  			@page.unliked_by current_user
  		else
  			@page.liked_by current_user
  		end	

 		 redirect_to @page 
  	end

  	def comment
  		@page = Page.find(params[:id])
		comment = @page.comments.create
		comment.title = params[:title]
		comment.comment = params[:comment]
		comment.save

		redirect_to @page
	end

end
