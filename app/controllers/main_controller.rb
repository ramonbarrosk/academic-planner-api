class MainController < ApplicationController
  skip_before_action :authenticate_cookie, only: [:index]
  def index
  end
end
