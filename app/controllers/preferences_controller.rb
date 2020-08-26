class PreferencesController < ApplicationController

  def overview
    @top_choices = Tag.where(category: 'top_choice')
    @ingredients = Ingredient.all
    @preferences = current_user.preferences
  end

  def deactivate
    preference = Preference.find(params[:id])
    preference.active = false
  end

  def create_with_ingredient
    @ingredient = Ingredient.find(params[:ingredient_id])
    @preference = Preference.new(kind: params[:kind])
    @preference.active = true
    @preference.ingredient = @ingredient
    @preference.save
  end

  def create_with_tag
    @tag = Tag.find(params[:tag_id])
    @preference = Preference.new()
    @preference.active = true
    @preference.tag = @tag
    @preference.user = current_user
    @preference.save
  end

  private

  def strong_params
    params.require(:preference).permit(:kind)
  end
end
