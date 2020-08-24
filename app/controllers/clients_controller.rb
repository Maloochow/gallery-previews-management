class ClientsController < ApplicationController
    before_action :authorized?

    def index
        clients = current_gallery.clients
        if params[:search]
            @clients = clients.search(params[:search])
        else
            @clients = clients
        end
    end

    def show
        @client = Client.find_by_id(params[:id])
    end

    def new
        @client = Client.new
    end

    def create
        @client = Client.find_or_create_by(client_params)
        if @client.save
            invite = @client.client_invites.build(client_id: @client.id)
            invite.update(invite_params)
            binding.pry
            invite.save
            redirect_to gallery_clients_path(current_gallery)
        else
            flash[:alert] = "Please fill in the client App ID"
            render :new
        end
    end

    private

    def client_params
        params.require(:client).permit(:app_id)
    end

    def invite_params
        params.require(:client).permit(:gallery_id, :user_id, :status)
    end
end
