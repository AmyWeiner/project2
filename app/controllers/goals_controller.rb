class GoalsController < ApplicationController
  require 'wolfram-alpha'

  def index
    @goals = Goal.all
  end

  def new
    @goal = Goal.new
  end

  def create
    query = params[:goal]

    options = { "format" => "plaintext"} # see the reference appendix in the documentation.[1]
    client = WolframAlpha::Client.new "WAH272-2G2QR5X7L6", options

    @response = client.query query["name"]

    # @response = client.query query
    # binding.pry
    result = @response.find { |pod| pod.id == "Result" }
    answer = result.subpods.first.plaintext

    @goal = Goal.new
    @goal.name = query["name"]
    # @goal.input_interpretation = @goal.input_interpretation
    @goal.input_interpretation = answer
    @goal.save

    render :show

  end

  def show
    @goal = Goal.find(params[:id])
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  # def update
  #   goal = Goal.find(params[:id])
  #   updated_goal = params.require(:goal).permit(:name, :distance)
  #   goal.update_attributes(updated_goal)
  #   if goal.save
  #     redirect_to goal
  #   end
  # end

  def delete
    goal = Goal.find(params[:id])
    goal.destroy
  end
end
