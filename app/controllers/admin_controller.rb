class AdminController < ApplicationController
layout "admin"
  def show

  end

  def edit
  end

  def show_questions
  	@questions = Question.all
  end

end
