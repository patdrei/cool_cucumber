class PreferencesController < ApplicationController

  def overview
      Tag.where(category: 'top_choice').select{|tag| tag.preferences.exists?(user: current_user)} == [] ? @top_choices = Tag.where(category: 'top_choice').sort_by{|tag| -tag.recipe_tags.count }.first(4) : @top_choices = Tag.where(category: 'top_choice').select{|tag| tag.preferences.exists?(user: current_user)}
      Tag.where(category: 'cuisines').select{|tag| tag.preferences.exists?(user: current_user)} == [] ? @cuisines = Tag.where(category: 'cuisines').sort_by{|tag| -tag.recipe_tags.count }.first(4) : @cuisines = Tag.where(category: 'cuisines').select{|tag| tag.preferences.exists?(user: current_user)}
      Tag.where(category: 'dish_types').select{|tag| tag.preferences.exists?(user: current_user)} == [] ? @types = Tag.where(category: 'dish_types').sort_by{|tag| -tag.recipe_tags.count }.first(4) : @types = Tag.where(category: 'dish_types').select{|tag| tag.preferences.exists?(user: current_user)}

      Ingredient.select{|ingredient| ingredient.preferences.exists?(user: current_user)} == [] ? @ingredients = Ingredient.all.sort_by{|ing| -ing.recipe_ingredients.count }.first(4) : @ingredients = Ingredient.select{|ingredient| ingredient.preferences.exists?(user: current_user)}

      @preferences = current_user.preferences
  end

  def deactivate
     Preference.destroy(params[:id])
    # @preference = Preference.find(params[:id])
    # @preference.active = false
    # @preference.save

    redirect_back(fallback_location: overview_path)
  end

  def destroy_all
    @preferences_annihilator = Preference.where(user: current_user)
    @preferences_annihilator.destroy_all
    redirect_back(fallback_location: overview_path)
  end

  def category
    @category = params[:category]

    if params[:query].present?
      @tags = Tag.where(category: @category).where("name ILIKE ?", "%#{params[:query].downcase}%")
    else
      @tags = Tag.where(category: @category)
    end
  end

  def ingredients
    @alphabet = ('a'..'z').to_a
    @preferences = current_user.preferences

    if params[:query].present?
      @pure_ingredients = Ingredient.where("name ILIKE ?", "%#{params[:query].downcase}%")
    else
      @ingredients = sort_ingredients
    end
  end

  def sort_ingredients
    ingredients = Ingredient.all
    array_of_arrays = []
    alphabet_array = ('a'..'z').to_a

    alphabet_array.each do |input|
      intermediate = ingredients.select do |i|
        i.name.first.downcase == input
      end
        array_of_arrays << intermediate
    end
    array_of_arrays
  end

  def create_with_ingredient
    if Preference.exists?(ingredient_id: params[:ingredient_id], user_id: current_user.id)
      preference = Preference.find_by(ingredient_id: params[:ingredient_id], user_id: current_user.id)
      Preference.destroy(preference.id)
    else
      @ingredient = Ingredient.find(params[:ingredient_id])
      @preference = Preference.new(strong_params)
      @preference.ingredient = @ingredient
      @preference.user = current_user
      @preference.save
    end
  end

  def create_with_tag
    if Preference.exists?(tag_id: params[:tag_id], user_id: current_user.id)
      preference = Preference.find_by(tag_id: params[:tag_id], user_id: current_user.id)
      Preference.destroy(preference.id)
    else
      @tag = Tag.find(params[:tag_id])
      @preference = Preference.new(strong_params)
      @preference.tag = @tag
      @preference.user = current_user
      @preference.save
    end
  end

  private

  def strong_params
    params.permit(:kind, :tag_id, :ingredient_id)
  end
end
