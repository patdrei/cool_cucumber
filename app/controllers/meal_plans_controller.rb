class MealPlansController < ApplicationController

  def new
    @meal_plan = MealPlan.new
    @show_mp = current_user.meal_plans.last != nil && current_user.meal_plans.last.active
    @top_choices = Tag.where(category: 'top_choice')
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

    @r_tags = tags.flatten

    @number.times do
      @meal = Meal.new
      @meal.meal_plan = @meal_plan
      @recipe = @r_tags.sample.recipe
      @meal.recipe = @recipe
      @meal.save
      @r_tags = @r_tags.select { |i| i.recipe_id != @recipe.id }
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
