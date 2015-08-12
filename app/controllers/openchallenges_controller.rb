class OpenchallengesController < ApplicationController

  def new
   @challenge = Challenge.new
  end

  def index
    @open_challenges = Challenge.all.select{|c| c.description.include?("created by")}
  end

  def create
    binding.pry
    @openchallenge = Challenge.create(openchallenge_params)
    @openchallenge.challenge_duration = params[:challenge][:challenge_duration].to_i * params[:challenge][:time_unit_challenge].to_i
    @openchallenge.description = @openchallenge.description.concat(": created by #{current_user.capitalize_name}")
    @openchallenge.challenge_end = Time.now + @openchallenge.challenge_duration.seconds
    @openchallenge.voting_duration = @openchallenge.challenge_duration
    @openchallenge.save
    
    redirect_to openchallenge_path(@openchallenge)
  end

  def show
    @openchallenge = Challenge.find(params[:id])
    
  end

  private

  def openchallenge_params
    params.require(:challenge).permit(:title, :description)
  end


end

