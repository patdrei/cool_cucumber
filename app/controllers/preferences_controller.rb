class PreferencesController < ApplicationController

  def overview
    @top_choices = Tag.where(category: 'top_choice')
    @cuisines = Tag.where(category: 'cuisines')
    @types = Tag.where(category: 'dish_types')

    @ingredients = Ingredient.all
    @preferences = current_user.preferences
  end

  def deactivate
     Preference.destroy(params[:id])
    # @preference = Preference.find(params[:id])
    # @preference.active = false
    # @preference.save

    redirect_back(fallback_location: overview_path)
  end

  def create_with_ingredient
    @ingredient = Ingredient.find(params[:ingredient_id])
    @preference = Preference.new(kind: params[:kind])
    @preference.active = true
    @preference.ingredient = @ingredient
    @preference.user = current_user
    @preference.save
    redirect_back(fallback_location: overview_path)
  end

  def create_with_tag
    @tag = Tag.find(params[:tag_id])
    @preference = Preference.new(strong_params)
    @preference.active = true
    @preference.tag = @tag
    @preference.user = current_user
    @preference.save
    redirect_back(fallback_location: overview_path)
  end

  private

  def strong_params
    params.permit(:kind)
  end
end
