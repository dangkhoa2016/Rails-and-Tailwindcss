class Admin::UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])  # Initialize the search query object

    @q.sorts = 'first_name asc, last_name asc' if @q.sorts.empty?

    @pagy, @users = pagy(@q.result(distinct: true), items: 10)
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def search_params
    {
      email_cont: params[:search_email],
      first_name_cont: params[:search_first_name],
      last_name_cont: params[:search_last_name]
    }.compact
  end
end
