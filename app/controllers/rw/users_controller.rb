module Rw
  class UsersController < ApplicationController
    before_action :require_login, except: [:new, :create, :activate]
    prepend_before_action :check_captcha, only: [:create]

    def user_list
    end

    def user_datatable
      respond_to do |format|
        format.html
        format.json { render json: FetchUsers.call(view: view_context).result }
      end
    end

    def new_user_form
      @user = UserForm.new(User.new(profile: Rw::Profile.new))
    end

    def create_user
      @user = UserForm.new(User.new(profile: Rw::Profile.new))
      result = UserCreate.call(user: @user, data: params[:rw_user], current_user: current_user)
      if result.success?
        flash.now[:notice] = t(:'messages.successful_save')
      else
        Rw::ModelErrors.call(model: @user, class_name: self)
      end
    rescue Exception => e
      @error = '1'
      logger.error(e.message)
      flash.now[:error] = e.message
    end

    def edit
      @user = UserEditForm.new(User.find(params[:id]))
    end

    def update
      result = UserUpdate.call(data: params[:rw_user])
      if result.success?
        flash.now[:notice] = t(:'messages.successful_save')
      else
        Rw::ModelErrors.call(model: result.user, class_name: self)
      end
    rescue Exception => e
      @error = '1'
      flash.now[:error] = e.message
    end

    def new
      @user = UserForm.new(User.new)
    end

    def destroy_user
      result = UserDestroy.call(id: params[:id], user: current_user)
      if result.success?
        flash.now[:notice] = t(:'messages.successful_destroy')
      else
        flash.now[:error] = result.error
      end
    end

    def create
      @user = UserForm.new(User.new)
      result = UserCreate.call(user: @user, data: params[:rw_user])
      if result.success?
        if result.current_user.activation_state == 'active'
          login(params[:rw_user][:email], params[:rw_user][:password])
          redirect_to root_path
        else
          flash.now[:notice] = t(:'messages.user_activation_notice')
          render :new
        end
      else
        render 'new'
      end
    end

    def user_type_form
      @user_types = Rw::UserType.all
      @id = params[:id]
    end


    def assign_user_type
      AssignUserType.call(user_id: params[:user_type][:user_id], user_type_id: params[:user_type][:user_type_id])
    end

    def activate
      @user = User.load_from_activation_token(params[:id])
      if @user
        @user.activate!
        flash[:success] = t(:'messages.activated')
        redirect_to log_in_path
      else
        flash[:error] = t(:'messages.not_activated')
        redirect_to root_path
      end
    end

    def agent_city_datatable
      respond_to do |format|
        format.html
        format.json {render json: FetchAgentCity.call(view: view_context, user_id: params[:user_id]).result}
      end
    end

    def destroy_agent_city
      if params[:id] == '0'
        @error = flash.now[:error] = t(:'messages.no_selection')
        return
      end
      Rw::AgentCity.where('id = ?', params[:id]).delete_all
      @user_id = params[:user_id]
      @agent_city = AgentCityForm.new(Rw::AgentCity.new)
      @selectable_city = Rw::AllCities.call.cities

      flash.now[:notice] = t(:'messages.successful_destroy')
    end

    def create_agent_city
      @user_id = params[:rw_agent_city][:user_id]
      @agent_city = AgentCityForm.new(Rw::AgentCity.new)
      result = AgentCityCreate.call(agent_city_data: params[:rw_agent_city],
                                                     user: current_user)

      if result.success?
        flash.now[:notice] = t(:'messages.successful_save')
      else
        Rw::ModelErrors.call(model: result.agent_city, class_name: self)
      end
      @selectable_city = Rw::AllCities.call.cities
    rescue Exception => e
      @error = '1'
      flash.now[:error] = e.message
    end

    def agent_city
      @user_id = params[:user_id]
      @agent_city = AgentCityForm.new(Rw::AgentCity.new)
      @selectable_city = Rw::AllCities.call.cities
    end    
    
    private

    def check_captcha
      real_person = params[:captcha]
      real_person_hash = params[:captchaHash]
      if !real_person.nil? && !real_person_hash.nil? && Integer(rp_hash(real_person)) == Integer(real_person_hash)
        true
      else
        @user = UserForm.new(User.new)
        flash.now[:alert] = I18n.t(:'recaptcha.error')
        render :new
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

  end
end