class StaticPagesController < ApplicationController

	def index
		@works = Work.all


	end

	def search

		@works = Work.search(params[:search]).order(created_at: :desc).limit(12)	
		respond_to do |format|
			format.js
			format.html
		end		
	end

	def why
		
	end
end
