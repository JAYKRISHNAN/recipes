require 'contentful'

$contentful ||= Contentful::Client.new(
  space: Rails.application.credentials.contentful[:space_id],
  access_token: Rails.application.credentials.contentful[:access_token]
)