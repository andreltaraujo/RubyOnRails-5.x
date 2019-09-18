module SiteHelper
  def msg_jumbotron
    case params[:action]
    when 'index'
      "Questões"
    when 'questions'
      "Resultado da pesquisa para o termo: " "#{params[:term]}"
    when 'subject'
      "Questões para o assunto: " "#{params[:question][:subject_id]}"
    end
  end
end
