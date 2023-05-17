class RecipesController < ApplicationController
  before_action(:load_matching_recipes)

  def load_matching_recipes
    require "open-uri"
    require "json"

    @spoonacular_key = ENV.fetch("SPOONACULAR_KEY")

    ingredients = Array.new

    @current_user.pantries.each do |pantry|
      ingredients.push(pantry.item)
    end


    spoonacular_url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{@spoonacular_key}&ingredients=#{ingredients}&ranking=2&number=20"
    #{BASE_URL}?apiKey=#{@api_key}&ingredients=#{ingredients.join(',')}

    raw_spoonacular_data = URI.open(spoonacular_url).read
    @parsed_spoonacular_data = JSON.parse(raw_spoonacular_data)

    #@results_array = parsed_spoonacular_data.fetch("results")

    # recipe id
  end
  
  def index
  end

  def show
    recipe_url = "https://api.spoonacular.com/recipes/#{the_id}/information?apiKey=#{@spoonacular_key}"
    raw_recipe_data = URI.open(recipe_url).read
    @the_recipe = JSON.parse(raw_recipe_data)
    the_id = params.fetch("path_id")


    render({ :template => "recipes/show.html.erb" })
  end

  def create
    the_recipe = Recipe.new

    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes", { :notice => "Recipe created successfully." })
    else
      redirect_to("/recipes", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)


    if the_recipe.valid?
      the_recipe.save
      redirect_to("/recipes/#{the_recipe.id}", { :notice => "Recipe updated successfully."} )
    else
      redirect_to("/recipes/#{the_recipe.id}", { :alert => the_recipe.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_recipe = Recipe.where({ :id => the_id }).at(0)

    the_recipe.destroy

    redirect_to("/recipes", { :notice => "Recipe deleted successfully."} )
  end
end
