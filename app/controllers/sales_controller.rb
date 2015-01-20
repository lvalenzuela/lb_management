class SalesController < ApplicationController
	protect_from_forgery
	before_filter :check_authentication
	layout "dashboard"
	
	def index
	end

	def promotions
		@promotions = get_promotions(params[:show_all])
	end

	def new_promotion
		@new_promotion = Promotion.new()
	end

	def create_promotion
	end

	def edit_promotion
	end

	def update_promotion
	end

	def delete_promotion
	end

	private

	def promotion_params
		params.require(:promotion).permit(:shortname, :fullname, :description, :start_date, :end_date, :discount_index)
	end

	def get_promotions(hidden_promotions)
		if hidden_promotions
			#retorna todas las promociones, activas e inactivas
			return Promotion.all()
		else
			#solo retorna las promociones activas actualmente
			return Promotion.where("curdate() between start_date and end_date").order("start_date ASC")
		end
	end

    def check_authentication
        if current_user.nil?
          redirect_to :controller => "users", :action => "index"
        end
    end
end
