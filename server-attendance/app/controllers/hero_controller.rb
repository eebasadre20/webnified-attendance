class HeroController < ApplicationController
	#before_action :check_attendance_status, only: :time

	def create_hero
		@hero = Hero.new(hero_params)

		respond_to do |format|

			if @hero.save
				format.json { render json: @hero, status: :created }
			else
				format.json { render json: @hero.errors, status: :unprocessable_entity }
			end
		end
	end

	def login_attempt		
		authorized_hero = Hero.authenticate(params[:username_or_email], params[:login_password])

		respond_to do |format|
			if authorized_hero
				session[:hero_id] = authorized_hero.id
				@current_hero = Hero.find(session[:hero_id])

				format.json { render json: hero, status: :ok }
			else
				status = { notice: "Username and Password didn't match!" }
				format.json { render json: status, status: :unprocessable_entity }
			end
		end
	end

	def time
		@hero = Hero.find(params[:hero_id])
		
			respond_to do |format|
				@time = Time.now
				if params[:status] == false 
					@hero_time = @hero.attendances.new(timein: @time, photoin: params[:photo_path])

					if @hero_time.save
					   @hero.update_columns(status: params[:status])
						
						format.json { render json: @hero, status: :ok }
					end

				elsif params[:status] == true
					@attendance = Attendance.find_by_hero_id(params[:hero_id])

					if @attendance.update_attributes(timeout: @time, photoout: params[:photo_path]) 
					  @hero.update_columns(status: params[:status])

						format.json { render json: @hero, status: :ok}
					end
				end

		end
	end

	private

	def hero_params
		params.require(:hero).permit(:firstname, :lastname, :company_position, :email, :contact_number, :gender, :username, :password, :status)
	end


end

