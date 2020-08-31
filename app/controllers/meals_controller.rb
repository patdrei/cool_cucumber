class MealsController < ApplicationController

  def destroy
    @meal = Meal.find(params[:id])
    @meal_plan = @meal.meal_plan
    @meal_plan.days -= 1
    meals_create_shopping_list_items
  end

  def create
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal = Meal.new
    @meal.meal_plan = @meal_plan
    @meal_plan.days += 1
    @m_recipes = @meal_plan.meals.map{ |meal| meal.recipe }
    new_meal
    redirect_back(fallback_location: new_meal_plan_path)
  end

  def shuffle
    @meal = Meal.find(params[:id])
    @meal_plan = @meal.meal_plan
    @m_recipes = @meal_plan.meals.map{ |meal| meal.recipe }
    new_meal
    redirect_back(fallback_location: new_meal_plan_path)
  end

  def new_meal
    @user = current_user
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
      @recipes.select!{|recipe| RecipeTag.exists?(recipe_id: recipe.id, tag_id: tag.id)}
    end

    @m_recipes.each do |rec|
      @recipes.select! {|i| i != rec }
    end

    if @recipes.length == 0
      @recipes = RecipeTag.where(tag_id: 2).map{|i| i.recipe}
    end

    @recipe = @recipes.sample
    @meal.recipe = @recipe
    @meal.save
    @recipes.select! { |i| i != @recipe }

    meals_create_shopping_list_items
  end

    def meals_create_shopping_list_items
    @meal_plan.shopping_list_items.destroy_all
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

end
