module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    private

    def authenticate_admin
      redirect_to new_user_session_path unless current_user.try(:admin?)
    end
  end
end
