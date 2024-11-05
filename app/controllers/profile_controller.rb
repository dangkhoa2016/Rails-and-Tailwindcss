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

  def edit_avatar
  end

  def update_avatar
    if params[:remove_avatar].present?
      handle_remove_avatar
      return
    end

    if avatar_params[:avatar].blank?
      current_user.errors.add(:avatar, 'cannot be blank')
      render_error_update_avatar
      return
    end

    # avatar = resize_avatar(avatar_params[:avatar])
    avatar = avatar_params[:avatar]
    current_user.profile_avatar.attach(avatar)

    if current_user.save
      flash[:notice] = 'Avatar updated'
      respond_to do |format|
        format.html {
          redirect_to profile_avatar_path
        }
        format.turbo_stream { render :update_avatar } # Render the Turbo Stream view
      end

      return
    end

    render_error_update_avatar
  end

  private

  def handle_remove_avatar
    begin
      current_user.profile_avatar.purge
      flash[:notice] = 'Avatar removed'
      respond_to do |format|
        format.html {
          redirect_to profile_avatar_path
        }
        format.turbo_stream { render :update_avatar } # Render the Turbo Stream view
      end
    rescue => e
      current_user.errors.add(:avatar, 'could not be removed')
      render_error_update_avatar
    end
  end

  def render_error_update_avatar
    respond_to do |format|
      format.html {
        render :edit_avatar
      }
      format.turbo_stream { render :update_avatar } # Render the Turbo Stream view
    end
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :first_name, :last_name, :phone_number, :birth_date)
  end

  def avatar_params
    params.fetch(:user, {}).permit(:avatar)
  end

  # def resize_avatar(avatar)
  #   io = MiniMagick::Image.read(avatar.tempfile)
  #   io.resize "300x300>"
  #   io = StringIO.new(io.to_blob) # Convert to StringIO for re-upload
  #   io.set_encoding('BINARY') # Ensure binary encoding is set
  #   io
  # end
end
