class MealPlansController < ApplicationController

  skip_before_action :authenticate_user!, only: [:show]

  def show
    @plan = MealPlan.find(params[:id])
  end

  def save_to_account
    @meal_plan = MealPlan.find(params[:id])
    @user = current_user
    @new_plan = MealPlan.new(active: true, days: @meal_plan.days)
    @new_plan.user = @user
    @new_plan.save
    @meal_plan.meals.each do |meal|
      new_meal = Meal.new(done: false, meal_plan_id: @new_plan.id, recipe_id: meal.recipe.id)
      new_meal.save
    end

    redirect_to edit_meal_plan_path(@new_plan.id)
  end

  def new
    @meal_plan = MealPlan.new
    @top_choices = Tag.where(category: 'top_choice')
    @plan = current_user.meal_plans.last
  end

  def create_shopping_list_items
    # create shopping list item
    # pass in ingredients  through the recipe_ingredients
    # same for amount
    # set purchased to true
    # check if any of those already exist
    # @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal_plan.meals.each do |meal|
      @recipe = meal.recipe
      @recipe_ingredients = @recipe.recipe_ingredients
      @recipe_ingredients.each do |recipe_ingredient|
        if ShoppingListItem.exists?(ingredient_id: recipe_ingredient.ingredient_id, meal_plan_id: @meal_plan.id)
          spi = ShoppingListItem.find_by(ingredient_id: recipe_ingredient.ingredient_id, meal_plan_id: @meal_plan.id)
          spi.amount += recipe_ingredient.standard_amount
        else
          ShoppingListItem.create(
            ingredient_id: recipe_ingredient.ingredient_id,
            amount: recipe_ingredient.standard_amount,
            purchased: false,
            meal_plan_id: @meal_plan.id
          )
        end
      end
    end
  end

  def create

    if params[:meal_plan][:days] == ""
      redirect_to new_meal_plan_path
      flash[:alert] = "Please say for how many days you want to cook"

    else

      deactivate_mealplans

      @meal_plan = MealPlan.new(strong_params)
      @meal_plan.active = true
      @user = current_user
      @meal_plan.user = @user
      @number = @meal_plan.days
      @meal_plan.save
      @preferences = @user.preferences.where(kind: 1, ingredient_id: nil)

      tags = @preferences.map do |pref|

        tag = pref.tag
        tag.recipe_tags
      end

      accepted = @preferences.map do |pref|

        pref.tag
      end
      @top_choices = accepted.select { |tag| tag.category == 'top_choice'}

      r_tags = tags.flatten
      @recipes = r_tags.map { |tag| tag.recipe }
      @top_choices.each do |tag|
        @recipes.select!{ |recipe| RecipeTag.exists?(recipe_id: recipe.id, tag_id: tag.id)}
      end


      @number = @recipes.uniq.length if @meal_plan.days > @recipes.uniq.length
      ing_pref_set

      @number.times do
        @meal = Meal.new
        @meal.meal_plan = @meal_plan
        @recipe = @recipes.sample
        @meal.recipe = @recipe
        @meal.save
        @recipes.select! { |i| i != @recipe }
      end
      safenum if @meal_plan.days > @recipes.uniq.length
      create_shopping_list_items
      redirect_to new_meal_plan_path
    end
  end

  def edit
    @plan = MealPlan.find(params[:id])
  end

  private

  def strong_params
    params.require(:meal_plan).permit(:days)
  end

  def deactivate_mealplans
    unless current_user.meal_plans.nil?
      mealplans = current_user.meal_plans
      mealplans.each do |mp|
        mp.active = false
        mp.save
      end
    end
  end

  def safenum
    @safenum = @number - @recipes.uniq.length
    @saferecs = RecipeTag.where(tag_id: 2).map{|i| i.recipe}

    @m_recipes = @meal_plan.meals.map{ |meal| meal.recipe }

    @m_recipes.each do |rec|
      @saferecs.select! {|i| i != rec }
    end

    @safenum.times do
      @meal = Meal.new
      @meal.meal_plan = @meal_plan
      @saferec = @saferecs.sample
      @meal.recipe = @saferec
      @meal.save
      @saferecs.select! { |i| i != @recipe }
    end

  end

  def ing_pref_set
    intermediary = @recipes.uniq
    @ingredients = current_user.preferences.where(tag_id: nil).map{|i| i.ingredient}
    unless @ingredients == []
      intermediary.each do |recipe|
        @ingredients.each do |ingredient|
          if RecipeIngredient.exists?(recipe_id: recipe.id, ingredient_id: ingredient.id)
            @recipes << recipe
          end
        end
      end
    end
  end
end
