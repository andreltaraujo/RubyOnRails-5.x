class Site::WelcomeController < SiteController
  def index
    @questions = Question.order_questions(params[:page])
  end
end
