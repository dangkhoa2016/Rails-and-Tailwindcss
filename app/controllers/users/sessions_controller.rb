class Users::SessionsController < Devise::SessionsController
  def destroy
    super do
      respond_to do |format|
        format.turbo_stream { render :destroy } # Render the Turbo Stream view
        format.html { redirect_to '/', notice: 'Signed out successfully.' }
      end
      return # Prevent further execution
    end
  end
end
