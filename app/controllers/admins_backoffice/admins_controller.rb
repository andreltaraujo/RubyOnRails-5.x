class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_admin, only: [:edit, :update, :destroy]
  before_action :get_admins, only: [:index, :new, :edit]
  
  def index
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Admin #{@admin.email} Cadastrado com Sucesso!"       
    else
      render :new
    end
  end

  def edit 
  end

  def update
    if @admin.update(params_admin)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to admins_backoffice_admins_path, notice: "Admin #{@admin.email} Atualizado com Sucesso!"       
    else
      render :edit
    end
  end

    def destroy
      if @admin.destroy
        redirect_to admins_backoffice_admins_path, notice: "Admin #{@admin.email} Removido com Sucesso!"       
      else
        render :index
      end
    end

  private

  def verify_password
    if params[:admin] [:password].blank? && params[:admin] [:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def get_admins
    @admins = Admin.all
  end

  def params_admin
    params.require(:admin).permit(:email, :password, :password_confirmation)
  end
end
