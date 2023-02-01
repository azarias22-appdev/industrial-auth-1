class UsersController < ApplicationController
  before_action :set_user, only: %i[ show liked feed followers following discover ]
  before_action :ensure_user_is_current_user, only: [:feed, :discover]

  private

    def ensure_user_is_current_user
      if @user != current_user
        redirect_back(fallback_location: root_url, alert: "You're not authorized for that")
      end
    end

    def set_user
      if params[:username]
        @user = User.find_by!(username: params.fetch(:username))
      else
        @user = current_user
      end
    end
end
