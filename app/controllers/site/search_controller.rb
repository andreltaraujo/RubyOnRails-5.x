class Site::SearchController < SiteController
  before_action :get_subjects, only: [:subject, :questions]
  
  def questions
    @questions = Question.search(params[:page], params[:term])
  end

  def subject
    @questions = Question.search_subject(params[:page], params[:question][:subject_id])
  end

  private

  def get_subjects
    @subjects = Subject.all
  end
end