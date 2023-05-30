class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.password == user.password_confirmation
            user.save
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error:"Passwords don't match"}, status: :unprocessable_entity
        end
    end

    def show
        user = User.find_by(id: session[:user_id])
        if user        
            render json: user
        else
            render json: {error: "Not authorized"}, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

end
