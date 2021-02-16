json.array! @contacts do |contact|
  json.extract! contact, :id, :subject, :content, :sent_at_formatted, :now_processing, :updated_at_formatted
end