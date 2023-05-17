class PantriesController < ApplicationController
  def index
    matching_pantries = Pantry.all

    @list_of_pantries = matching_pantries.order({ :created_at => :desc })

    render({ :template => "pantries/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_pantries = Pantry.where({ :id => the_id })

    @the_pantry = matching_pantries.at(0)

    render({ :template => "pantries/show.html.erb" })
  end

  def create
    the_pantry = Pantry.new
    the_pantry.item = params.fetch("query_item")
    the_pantry.category_id = params.fetch("query_category_id")
    the_pantry.user_id = params.fetch("query_user_id")

    if the_pantry.valid?
      the_pantry.save
      redirect_to("/pantries", { :notice => "Pantry created successfully." })
    else
      redirect_to("/pantries", { :alert => the_pantry.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_pantry = Pantry.where({ :id => the_id }).at(0)

    the_pantry.item = params.fetch("query_item")
    the_pantry.category_id = params.fetch("query_category_id")
    the_pantry.user_id = params.fetch("query_user_id")

    if the_pantry.valid?
      the_pantry.save
      redirect_to("/pantries/#{the_pantry.id}", { :notice => "Pantry updated successfully."} )
    else
      redirect_to("/pantries/#{the_pantry.id}", { :alert => the_pantry.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_pantry = Pantry.where({ :id => the_id }).at(0)

    the_pantry.destroy

    redirect_to("/pantries", { :notice => "Pantry deleted successfully."} )
  end
end
