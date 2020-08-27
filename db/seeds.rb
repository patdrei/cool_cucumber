# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'open-uri'

# url = 'https://api.spoonacular.com/recipes/random?apiKey=c2714ee57f804378906284a25d1ce700'
# recipes = open(url).read
# info = JSON.parse(recipes)

# recipes_array = info.recipes[0]

# puts recipes_array

# Tag.new()

#
require 'json'
require 'rest-client'

#create 5 tags




tag_array = ['vegetarian', 'vegan', 'glutenFree', 'dairyFree', 'veryHealthy', 'cheap', 'veryPopular', 'sustainable']


tag_array.each do |tag_name|
  unless Tag.exists?(name: tag_name)
    Tag.create(name: tag_name, category: 'top_choice')
  end
end


# Tag.create(name: 'vegetarian', category: 'top_choice')
# Tag.create(name: 'vegan', category: 'top_choice')
# Tag.create(name: 'glutenFree', category: 'top_choice')
# Tag.create(name: 'dairyFree', category: 'top_choice')
# Tag.create(name: 'veryHealthy', category: 'top_choice')
# Tag.create(name: 'cheap', category: 'top_choice')
# Tag.create(name: 'veryPopular', category: 'top_choice')
# Tag.create(name: 'sustainable', category: 'top_choice')


def set_tag(string, recipes_hash, recipe)
  if recipes_hash[string]
    recipe_tag = RecipeTag.new()
    tag = Tag.find_by(name: string)
    recipe_tag.tag = tag
    recipe_tag.recipe = recipe
    recipe_tag.save
  end
end

def set_andvanced_tags(advanced_tags_array, recipe, category)
  advanced_tags_array.each do |advanced_tag|
    if Tag.exists?(name: advanced_tag)
      recipe_tag = RecipeTag.new()
      existing_tag = Tag.find_by(name: advanced_tag)
      recipe_tag.tag = existing_tag
      recipe_tag.recipe = recipe
      recipe_tag.save
    else
      recipe_tag = RecipeTag.new()
      tag = Tag.new(name: advanced_tag, category: category)
      recipe_tag.tag = tag
      recipe_tag.recipe = recipe
      recipe_tag.save
    end
  end
end

def set_ingredients(ingredients_array, recipe)
  ingredients_array.each do |ingredient|
    a = RestClient.get "https://api.spoonacular.com/recipes/convert?ingredientName=#{ingredient['name']}&sourceAmount=#{ingredient['amount']}&sourceUnit=#{ingredient['unit']}&targetUnit=grams&apiKey=ccbbbc4b94f44e508ad540ed35565cbc"
    amount = JSON.parse(a)
    if Ingredient.exists?(name: ingredient['name'])
      existing_ingredient = Ingredient.find_by(name: ingredient['name'])
      recipe_ingredient = RecipeIngredient.new( amount: ingredient['amount'])
      recipe_ingredient.ingredient = existing_ingredient
      recipe_ingredient.recipe = recipe
      recipe_ingredient.save
    else
      recipe_ingredient = RecipeIngredient.new( amount: ingredient['amount'])
      new_ingredient = Ingredient.new(name: ingredient['name'], unit: "grams")
      new_ingredient.save
      recipe_ingredient.ingredient = new_ingredient
      recipe_ingredient.recipe = recipe
      recipe_ingredient.save
    end
  end
end


5.times do

  rm = RestClient.get 'https://api.spoonacular.com/recipes/random?apiKey=ccbbbc4b94f44e508ad540ed35565cbc'
  rm_array = JSON.parse(rm)


  recipes_hash = rm_array["recipes"][0]
  ingredients_array = recipes_hash["extendedIngredients"]

  cuisines_array = recipes_hash["cuisines"]
  dish_types_array = recipes_hash["dishTypes"]
  occasions_array = recipes_hash["occasions"]


  unless Recipe.exists?(name: recipes_hash["title"])

    recipe = Recipe.new(name: recipes_hash["title"], description: recipes_hash["summary"], instructions: recipes_hash["instructions"], image_url: recipes_hash["image"])
    recipe.save

    tag_array.each do |tag|
      set_tag(tag, recipes_hash, recipe)
    end

    set_ingredients(ingredients_array, recipe)
    set_andvanced_tags(cuisines_array, recipe, "cuisines")
    set_andvanced_tags(dish_types_array, recipe, "dish_types")
    set_andvanced_tags(occasions_array, recipe, "occasions")
  end
end



# vegitarian: recipe.vegitarian, vegan: recipe.vegan, glutenFree: recipe.glutenFree, dairyFree: recipe.dairyFree, healthy: recipe.veryHealthy, cheap: recipe.cheap
