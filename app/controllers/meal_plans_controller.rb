class MealPlansController < ApplicationController
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
        next if pref.tag_id.nil?

        tag = pref.tag
        tag.recipe_tags
      end
      accepted = @preferences.map do |pref|
        next if pref.tag_id.nil?

        pref.tag
      end
      @top_choices = accepted.select { |tag| tag.category == 'top_choice'}

      r_tags = tags.flatten
      @recipes = r_tags.map { |tag| tag.recipe }
      @top_choices.each do |tag|
        @recipes.select!{ |recipe| RecipeTag.exists?(recipe_id: recipe.id, tag_id: tag.id)}
      end

      safenum if @number > @recipes.uniq.length

      ing_pref_set

      @number.times do
        @meal = Meal.new
        @meal.meal_plan = @meal_plan
        @recipe = @recipes.sample
        @meal.recipe = @recipe
        @meal.save
        @recipes.select! { |i| i != @recipe }
      end
      create_shopping_list_items
      redirect_to new_meal_plan_path
    end
  end

  def edit
    @plan = MealPlan.find(params[:id])
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
    @number = @recipes.uniq.length
    @saferecs = RecipeTag.where(tag_id: 2).map{|i| i.recipe}

    @safenum.times do
      @meal = Meal.new
      @meal.meal_plan = @meal_plan
      @saferec = @saferecs.sample
      @meal.recipe = @saferec
      @meal.save
    end

    flash[:alert] = "The last #{@safenum} recipes are nice but don't fit all your preferences"
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
