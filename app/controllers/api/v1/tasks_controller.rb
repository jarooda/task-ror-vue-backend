module Api
  module V1
    class TasksController < ApplicationController
      before_action :authorized
      before_action :set_task, only: [:show, :update, :destroy]

      # GET /tasks
      def index
        @tasks = Task.where user: @user.id

        render json: @tasks
      end

      # GET /tasks/1
      def show
        render json: @task
      end

      # POST /tasks
      def create
        @task = Task.new(task_params)
        @task.user = @user

        if @task.save
          render json: @task, status: :created, location: url_for([:api, :v1, @task])
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tasks/1
      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # DELETE /tasks/1
      def destroy
        @task.destroy

        render json: { message: "Task deleted." }
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_task
          @task = Task.find(params[:id])
          
          if @task.user_id != @user.id
            render json: { message: "Not authorized." }, status: :unauthorized
          end
        end

        # Only allow a list of trusted parameters through.
        def task_params
          params.require(:task).permit(:title, :description, :priorities, :due_date, :status, :user_id)
        end
    end
  end
end