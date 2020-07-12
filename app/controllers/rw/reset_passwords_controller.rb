module Rw
  class ResetPasswordsController < ApplicationController
    skip_before_action :require_login

    def new
    end

    def create
      if params[:user][:email] == ''
        flash[:error] = 'خطا'
        render :new
      else
        @user = User.find_by_email(params[:user][:email])
        @user.deliver_reset_password_instructions! if @user
        flash[:success] = t(:'messages.reset_password')
        redirect_to log_in_path
      end
    end

    def edit
      @token = params[:id]
      @user = User.load_from_reset_password_token(@token)

      not_authenticated if @user.blank?
    end

    def update
      @token = params[:id]
      @user = User.load_from_reset_password_token(@token)

      not_authenticated && return if @user.blank?

      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.change_password!(params[:user][:password])
        flash[:success] = t('messages.password_changed')
        redirect_to log_in_path
      else
        render 'edit'
      end
    end
  end
end