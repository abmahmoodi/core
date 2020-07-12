module Rw
  class SessionsController < ApplicationController
    skip_before_action :require_login, except: [:destroy]
    prepend_before_action :check_captcha, only: [:create]
    after_action :after_login, :only => :create

    def new
    end

    def create
      if login(params[:user][:email], params[:user][:password])
        flash[:success] = t(:'messages.sign_in')
        redirect_back_or_to root_path
      else
        flash.now[:error] = t(:'messages.sign_in_error')
        render 'new'
      end
    end

    def destroy
      logout
      flash[:success] = t(:'messages.sign_out')
      redirect_to log_in_path
    end

    private

    def check_captcha
      real_person = params[:captcha]
      real_person_hash = params[:captchaHash]
      if !real_person.nil? && !real_person_hash.nil? && Integer(rp_hash(real_person)) == Integer(real_person_hash)
        true
      else
        true 
        # flash.now[:alert] = I18n.t(:'recaptcha.error')
        # render :new
      end
    end

    def rp_hash(default_real)
      hash = 5381
      if !default_real.nil?
        default_real.upcase!
        default_real.length.times { |i| hash = ((shift_32(hash, 5)) + hash) + default_real[i].ord }
      end
      hash
    end

    def shift_32(x, shift_amount)
      shift_amount &= 0x1F
      x <<= shift_amount
      x &= 0xFFFFFFFF
      if (x & (1 << 31)).zero?
        x
      else
        x - 2**32
      end
    end

    def after_login
      if current_user
        user = Rw::User.find_by_id(current_user.id)
        user.login_count = 0 if user.login_count.nil?
        user.increment(:login_count)
        user.save
      end
    end

  end
end