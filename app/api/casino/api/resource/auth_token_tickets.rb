require 'grape'
include CASino::SessionsHelper

class CASino::API::Resource::AuthTokenTickets < Grape::API
  resource :auth_token_tickets do
    desc 'Create an auth token ticket'
    post do
      @ticket = CASino::AuthTokenTicket.create
      Rails.logger.debug "Created auth token ticket '#{@ticket.ticket}'"
      present @ticket, with: CASino::API::Entity::AuthTokenTicket
    end

    get do
      @ticket_granting_ticket = current_ticket_granting_ticket
      Rails.logger.debug "Retrieving ticket granting ticket from cookies[:tgt]: #{cookies[:tgt]}"
      present @ticket_granting_ticket, with: CASino::API::Entity::AuthTokenTicket
    end
  end
end