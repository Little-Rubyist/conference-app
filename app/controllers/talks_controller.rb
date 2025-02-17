class TalksController < ApplicationController
  # @rbs @event: Event
  # @rbs @talks: Talk::ActiveRecord_Relation
  # @rbs @current_user_bookmarks: Array[TalkBookmark]
  # @rbs @talk: Talk

  # @rbs return: void
  def index
    @event = Event.find_by!(slug: params[:event_slug])
    @talks = Talk.eager_load(speakers: {avatar_attachment: :blob}).where(event: @event).order(:start_at, :track)
    @current_user_bookmarks = logged_in? ? TalkBookmark.where(user: current_user!).to_ary : []
  end

  # @rbs return: void
  def show
    @event = Event.find_by!(slug: params[:event_slug])
    @talk = Talk.eager_load(speakers: {avatar_attachment: :blob}).find(params[:id])
    @current_user_bookmarks = logged_in? ? TalkBookmark.where(user: current_user!, talk: @talk).to_ary : []
  end
end
