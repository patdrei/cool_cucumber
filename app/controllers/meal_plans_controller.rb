class MealPlansController < ApplicationController

  def new
    @meal_plan = MealPlan.new
    @top_choices = Tag.where(category: 'top_choice')
    @plan = current_user.meal_plans.last
  end

  def create
    deactivate_mealplans
    @meal_plan = MealPlan.new(strong_params)
    @meal_plan.active = true
    @user = current_user
    @meal_plan.user = @user
    @number = @meal_plan.days
    @meal_plan.save
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

    @number.times do
      @meal = Meal.new
      @meal.meal_plan = @meal_plan
      @recipe = @recipes.sample
      @meal.recipe = @recipe
      @meal.save
      @recipes.select! { |i| i != @recipe }
    end

    redirect_to new_meal_plan_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def strong_params
    params.require(:meal_plan).permit(:days)
  end

  def deactivate_mealplans
    mealplans = current_user.meal_plans
    mealplans.each { |mp| mp.active = false }
  end

end
