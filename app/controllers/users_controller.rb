require 'benchmark'
require 'ruby-prof'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Custom actions
  def benchmark
    Benchmark.bm do |x|
      x.report("UserJoinSocialAccounts: ") do
        User.joins(:social_accounts).all
      end
    end
  end

  def slow
    # Start the profiler
    RubyProf.start

    @data = {}
    User.all.each do |user|
      user_data = {
        accounts: [],
        name: user.name, email: user.email
      }
      user.social_accounts.each do |sa|
        user_data[:accounts] << {type: sa.social_account_type.name, name: sa.social_name}
      end
      @data[user.id] = user_data
    end

    # Stop the profiler
    result = RubyProf.stop

    # Write the results
    printer = RubyProf::MultiPrinter.new(result)
    printer.print(:path => "./public/slow", :profile => "profile")
  end

  def improved
    # Start the profiler
    RubyProf.start

    @data = {}
    User.includes(social_accounts: [:social_account_type]).each do |user|
      user_data = {
        accounts: [],
        name: user.name, email: user.email
      }
      user.social_accounts.each do |sa|
        user_data[:accounts] << {type: sa.social_account_type.name, name: sa.social_name}
      end
      @data[user.id] = user_data
    end

    # Stop the profiler
    result = RubyProf.stop

    # Write the results
    printer = RubyProf::MultiPrinter.new(result)
    printer.print(:path => "./public/improved", :profile => "profile")
  end

  def quick
    # Start the profiler
    RubyProf.start

    @data = {}
    @data.default = {}
    User
      .select("users.email, users.name, social_accounts.social_name, social_account_types.name as sa_name")
      .joins(social_accounts: [:social_account_type])
      .map do |user|
        @data[user.id][:name] = user.name
        @data[user.id][:email] = user.email
        @data[user.id][:accounts] ||= []
        @data[user.id][:accounts] << {type: user.sa_name, name: user.social_name}
      end

    # Stop the profiler
    result = RubyProf.stop

    # Write the results
    printer = RubyProf::MultiPrinter.new(result)
    printer.print(:path => "./public/quick", :profile => "profile")
  end

  ###### Generated actions #######

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :age)
    end
end
