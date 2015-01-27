class AddPromotionData < ActiveRecord::Migration
  def up
  	#Genera los datos de la primera promocion que se utilizará
  	#datos generales de la promocion
  	referral_promo = Promotion.find_by_shortname("user_referral")
  	if referral_promo.blank?
	  	new_promo = Promotion.create(	:shortname => "user_referral",
	  						:fullname => "Referencias de Usuarios Longbourn",
	  						:description => "Promoción que fomenta que los usuarios referencien Longbourn a sus amigos.",
	  						:start_date => "2015-01-01",
	  						:end_date => "2015-03-31",
	  						:discount_index => 10)
	  	PromotionUserAttribute.create(:attribute_name => "promo_token", :promotion_id => new_promo.id, :sort_order => 1, :enabled => true, :attribute_description => "Código único por usuario")
	  	PromotionUserAttribute.create(:attribute_name => "referral_counter", :promotion_id => new_promo.id, :sort_order => 2, :enabled => true, :attribute_description => "Contador de referencias por usuario")
	  	PromotionUserAttribute.create(:attribute_name => "facebook_enabled", :promotion_id => new_promo.id, :sort_order => 3, :enabled => true, :attribute_description => "Booleano que identifica si el usuario esta en facebook")
	  	PromotionUserAttribute.create(:attribute_name => "total_discount", :promotion_id => new_promo.id, :sort_order => 4, :enabled => true, :attribute_description => "Descuento total del usuario producto de la promocion.")
      PromotionUserAttribute.create(:attribute_name => "referenced_user_id", :promotion_id => new_promo.id, :sort_order => 5, :enabled => true, :attribute_description => "ID de los usuarios referenciados por el usuario participante en la promocion (para prevenir duplicaciones)")
	end
  end

  def down
  	referral_promo = Promotion.find_by_shortname("user_referral")
  	if !referral_promo.blank?
  		PromotionUserAttribute.where(:promotion_id => referral_promo.id).destroy_all
  		PromotionUser.where(:promotion_id => referral_promo.id).destroy_all
  		Promotion.find(referral_promo.id).delete
  	end
  end
end
