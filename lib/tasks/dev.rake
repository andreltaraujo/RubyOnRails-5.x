namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_FILES_PATH = File.join(Rails.root, 'lib', 'tmp')

    desc "Configura o ambiente de desenvolvimento"
    task setup: :environment do
  
      if Rails.env.development?
        show_spinner("Apagando BD...") { %x(rails db:drop:_unsafe) }
        show_spinner("Criando BD...") { %x(rails db:create) }
        show_spinner("Migrando BD...") { %x(rails db:migrate) }
        show_spinner("Cadastrando ADMIN padrão...") { %x(rails dev:add_default_admin) }
        show_spinner("Cadastrando outros ADMINS...") { %x(rails dev:add_others_admins) }
        show_spinner("Cadastrando USER padrão...") { %x(rails dev:add_default_user) }
        show_spinner("Cadastrando ASSUNTOS...") { %x(rails dev:add_subjects) }
        show_spinner("Cadastrando PERGUNTAS e RESPOSTAS...") { %x(rails dev:add_questions_and_answers) }
        #%x(rails dev:add_mining_types)
      else
        puts "Você não está no ambiente do desenvolvimento!"
      end
    end

    desc "Adiciona o administrador padrão"
    task add_default_admin: :environment do
      Admin.create!(
        email: 'admin@admin.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
        )
    end

    desc "Adiciona outros administradores"
    task add_others_admins: :environment do
      10.times do
        Admin.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD
          )
      end
    end

    desc "Adiciona o usuário padrão"
    task add_default_user: :environment do
      User.create!(
        email: 'user@user.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
        )
    end

    desc "Adiciona assuntos"
    task add_subjects: :environment do
      file_name = 'subjects.txt'
      file_path = File.join(DEFAULT_FILES_PATH, file_name)
      File.open(file_path, 'r').each do |line|
      Subject.find_or_create_by(description: line.strip)
      end
    end

    desc "Adiciona perguntas e respostas"
    task add_questions_and_answers: :environment do
      Subject.all.each do |subject|
        rand(3..7).times do |i|
        Question.create!(
        description: "#{Faker::Lorem.question(word_count: 16)}",
        subject: subject
        )
        end
      end
    end

    private

  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
