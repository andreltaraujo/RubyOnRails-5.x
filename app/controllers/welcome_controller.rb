class WelcomeController < ApplicationController
  http_basic_authenticate_with name: "andre", password: "123"

  def index
  end
end
