class Page < ActiveRecord::Base
	belongs_to :resume
	 acts_as_votable
acts_as_commentable

end
