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
		@new_promotion = Promotion.create(promotion_params)
		if @new_promotion.valid?
			redirect_to :action => :promotions
		else
			render "sales/new_promotion"
		end
	end

	def edit_promotion
		@promotion = Promotion.find(params[:id])
	end

	def update_promotion
		@promotion = Promotion.find(params[:promotion][:id])
		@promotion.update_attributes(promotion_params)
		if @promotion.valid?
			redirect_to :action => :promotions
		else
			render "sales/edit_promotion"
		end
	end

	def delete_promotion
		promotion = Promotion.find(params[:id])
		if !promotion.blank?
			promotion.destroy
		end
		redirect_to :action => :promotions
	end

	def promotion_config
		@promotion = Promotion.find(params[:id])
		if params[:show_disabled]
			@promotion_attributes = PromotionUserAttribute.where(:promotion_id => params[:id])
		else
			@promotion_attributes = PromotionUserAttribute.where(:promotion_id => params[:id], :enabled => true)
		end
	end

	def create_promotion_attribute
		@promotion_attribute = PromotionUserAttribute.create(promotion_attribute_params)
		if @promotion_attribute.valid?
			flash[:notice] = "Atributo creado satisfactoriamente"
		else
			flash[:notice] = "No fue posible crear el atributo."
		end
		redirect_to :action => :promotion_config, :id => params[:promotion_attribute][:promotion_id]
	end

	def update_promotion_attribute
		@promotion_attribute = PromotionUserAttribute.find(params[:promotion_attribute][:id])
		@promotion_attribute.update_attributes(promotion_attribute_params)
		redirect_to :action => :promotion_config, :id => params[:promotion_attribute][:promotion_id]
	end

	def edit_promotion_attribute
		@promotion_attribute = PromotionUserAttribute.find(params[:id])
		@promotion = Promotion.find(@promotion_attribute.promotion_id)
	end

	def disable_promotion_attribute
		promotion_attribute = PromotionUserAttribute.find(params[:id])
		promotion_attribute.enabled = false
		promotion_attribute.save!
		redirect_to :action => :promotion_config, :id => promotion_attribute.promotion_id
	end

	private

	def promotion_attribute_params
		params.require(:promotion_attribute).permit(:promotion_id, :attribute_name, :attribute_description, :enabled)
	end

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
