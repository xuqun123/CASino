require 'grape'

class CASino::API::Resource::AuthTokenTickets < Grape::API

  resource :auth_token_tickets do
    desc 'Create an auth token ticket'
    post do
      @ticket = CASino::AuthTokenTicket.create
      Rails.logger.debug "Created auth token ticket '#{@ticket.ticket}'"
      present @ticket, with: CASino::API::Entity::AuthTokenTicket
    end

    get do
      @ticket_granting_ticket = CASino::TicketGrantingTicket.where(ticket: cookies[:tgt]).first
      Rails.logger.debug "Retrieving ticket granting ticket #{cookies[:tgt]}: '#{@ticket_granting_ticket.try(:ticket)}'"
      present @ticket_granting_ticket, with: CASino::API::Entity::AuthTokenTicket
    end
  end
end
