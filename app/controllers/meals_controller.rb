class MealsController < ApplicationController

  def index
  end

  def shuffle
    meal = Meal.find(params[:id])
    @meal_plan = meal.meal_plan
    @m_recipes = @meal_plan.meals.map{|meal| meal.recipe}
    meal.destroy
    new_meal
  end

  def new_meal
    @user = current_user
    @preferences = @user.preferences.where(kind: 1)
    tags = @preferences.map do |pref|
      # next if pref.tag.id == nil
      tag = pref.tag
      tag.recipe_tags
    end
    accepted = @user.preferences.map { |pref| pref.tag }
    @top_choices = accepted.select { |tag| tag.category == 'top_choice'}

    r_tags = tags.flatten

    @recipes = r_tags.map { |tag| tag.recipe }

    @top_choices.each do |tag|
      @recipes.select!{ |recipe| RecipeTag.exists?(recipe_id: recipe.id, tag_id: tag.id)}
    end

    @m_recipes.each do |rec|
      @recipes.select! {|i| i != rec }
    end

    @meal = Meal.new
    @meal.meal_plan = @meal_plan
    @recipe = @recipes.sample
    @meal.recipe = @recipe
    @meal.save
    @recipes.select! { |i| i != @recipe }
  end
end
