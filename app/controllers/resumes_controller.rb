class ResumesController < ApplicationController
  before_action :authenticate_user!
  def index
    @resumes = Resume.all
  end

  def new
    @resume = Resume.new
    
  end

  def create
    @resume = Resume.new(resume_params)

    if @resume.save
        pdf_pages = Grim.reap(Rails.root.to_s + '/public/' + @resume.attachment_url)
        i = 1
        pdf_pages.each do |pdf_page|
          page_path = Rails.root.to_s + "/public/uploads/#{@resume.class.to_s.underscore}/attachment/#{@resume.id}/page_#{i}.png"
          pdf_page.save(page_path)
          p= Page.new
          p.path="/uploads/#{@resume.class.to_s.underscore}/attachment/#{@resume.id}/page_#{i}.png"
          p.save
          @resume.pages << p
          i+=1
        end
        redirect_to resume_path(@resume.id), notice: "The resume #{@resume.name} has been uploaded."
    else
      render "new"
    end
  end

  def show
     @resume = Resume.find(params[:id] )
    
  end

  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    redirect_to resumes_path, notice:  "The resume #{@resume.name} has been deleted."
  end



private
  def resume_params
    params.require(:resume).permit(:name, :attachment)
  end
end
