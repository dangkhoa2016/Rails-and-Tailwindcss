class ProfileController < ApplicationController
  def show
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = 'Profile updated'
      respond_to do |format|
        format.html {
          redirect_to profile_path
        }
        format.turbo_stream { render :update } # Render the Turbo Stream view
      end
    else
      respond_to do |format|
        format.html {
          render :edit
        }
        format.turbo_stream { render :update } # Render the Turbo Stream view
      end
    end
  end

  def edit
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :phone_number)
  end
end
