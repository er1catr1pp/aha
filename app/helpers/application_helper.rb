module ApplicationHelper

  # track the current session so that there
  # is no need to pass tokens or client info around
  def current_session
    current_sess = session[:current_session_id] ? Session.find(session[:current_session_id]) : nil
  end

end
