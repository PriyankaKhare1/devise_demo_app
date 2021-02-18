# frozen_string_literal: true
require 'bcrypt'

class Users::SessionsController < Devise::SessionsController
  protect_from_forgery :except => [:disable]
  include BCrypt
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new

  # end

  # POST /resource/sign_in
  def create
    @user = User.find_by(email: params[:user][:login]) || User.find_by(username: params[:user][:login])
    if @user.present?
      valid_password?
    else
      redirect_to unauthenticated_root_path, {notice: 'User not found, Please try again.'}
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def valid_password?
    bcrypt   = ::BCrypt::Password.new(@user.encrypted_password)
    password = ::BCrypt::Engine.hash_secret("#{params[:user][:password]}#{@user.class.pepper}", bcrypt.salt)
    if (password == bcrypt) && (@user.active == true)
      sign_in @user
      redirect_to authenticated_root_path, {notice: 'User Signed in successfully.'}
    elsif (password == bcrypt) && (@user.active == false)
      redirect_to unauthenticated_root_path, {notice: 'User is disable.'}
    else
      redirect_to unauthenticated_root_path, {notice: 'Invalid Password, Please try again with correct password.'}
    end
  end

  def disable
    @user = User.find(params[:id])
    @user.isActive
    flash[:notice] = 'Successfully Changes Account status'
    redirect_to authenticated_root_path
  end

end
