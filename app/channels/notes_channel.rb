class NotesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'notes'  #the name of our channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)   # called when data is sent to ‘/cable’.
    
    note = Note.find(data["id"])   # We take data, find the corresponding note, and update it.
    note.update!(text: data["text"])
   
    ActionCable.server.broadcast('notes', data)
  end
end
