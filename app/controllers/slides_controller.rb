class SlidesController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy]
		
	def index
	if params[:course].blank?
			@slides = Slide.all.order("created_at DESC")
		else
			@course_id = Course.find_by(name: params[:course]).id
			@slides = Slide.where(:course_id => @course_id).order("created_at DESC")
		end
	end
	
	def show	
	end

	def new
	@slide=current_user.slides.build
	@courses=Course.all.map {|c| [c.name, c.id]}
	end

	def create
	@slide=current_user.slides.build(slide_params)
	@slide.course_id= params[:course_id]
	if @slide.save
	redirect_to root_path
	else
	render 'new'
	end
	end
	
	def edit
	@courses=Course.all.map {|c| [c.name, c.id]}
	end
	
	def update
	@slide.course_id= params[:course_id]
	if @slide.update(slide_params)
	redirect_to slide_path(@slide)
	else
	render 'edit'
	end
	end

	def destroy
	@slide.destroy
	redirect_to root_path
	end

	private
	def slide_params
	params.require(:slide).permit(:Title,:Instructor, :category_id)
	end
	
	def find_book
	@slide=Slide.find(params[:id])
	end
end