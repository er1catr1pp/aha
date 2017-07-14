class SessionsController < ApplicationController
  
  def new
  end

  def create

    @session = Session.new()
    # make sure access was granted to Aha! account
    if not session_params[:error] == "access_denied"
      
      # use the oauth2 code to retrieve a token
      # and create an associated session
      redirect_uri = Rails.application.secrets[:aha][:oauth2][:redirect_uri]
      token = session_params[:explicit_token] || Aha::Client.new.auth_code.get_token(session_params[:code], :redirect_uri => redirect_uri).to_hash.to_json
      @session = Session.new(:token => token)  

    end

    if @session.save
      session[:current_session_id] = @session.id
      redirect_to session_path(@session)
    else
      session[:current_session_id] = nil
      flash[:notice] = 'Your account could not be authorized.'
      redirect_to root_url
    end

  end

  def show

    # if a current session exists, show the associated funnel report
    if current_session
      @idea_status_funnel = current_session.idea_status_funnel
    else
      redirect_to root_url
    end

  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.permit(:code, :status, :explicit_token, :error)
  end

end