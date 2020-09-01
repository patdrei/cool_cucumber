class PreferencesController < ApplicationController

  def overview
    if params[:query].present?
      @top_choices = Tag.where(category: 'top_choice').where("name LIKE ?", "%#{params[:query].downcase}%")
      @cuisines = Tag.where(category: 'cuisines').where("name LIKE ?", "%#{params[:query].downcase}%")
      @types = Tag.where(category: 'dish_types').where("name LIKE ?", "%#{params[:query].downcase}%")

      @ingredients = Ingredient.where("name LIKE ?", "%#{params[:query].downcase}%")
    else
      @top_choices = Tag.where(category: 'top_choice').first(4)
      @cuisines = Tag.where(category: 'cuisines').sort_by{|tag| -tag.recipe_tags.count }.first(4)
      @types = Tag.where(category: 'dish_types').sort_by{|tag| -tag.recipe_tags.count }.first(4)

      @ingredients = Ingredient.all.sort_by{|ing| -ing.recipe_ingredients.count }.first(4)
  end
    @preferences = current_user.preferences
  end

  def deactivate
     Preference.destroy(params[:id])
    # @preference = Preference.find(params[:id])
    # @preference.active = false
    # @preference.save

    redirect_back(fallback_location: overview_path)
  end

  def category
    @category = params[:category]
    @tags = Tag.where(category: @category)
  end

  def ingredients
    @alphabet = ('a'..'z').to_a
    @preferences = current_user.preferences

    if params[:query].present?
      @pure_ingredients = Ingredient.where("name LIKE ?", "%#{params[:query].downcase}%")

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
