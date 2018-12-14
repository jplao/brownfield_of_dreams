class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    if @facade.videos == []
      flash[:notice] = 'Sorry, there are no videos associated with this tutorial.'
      redirect_to '/'
    end
  end
end
