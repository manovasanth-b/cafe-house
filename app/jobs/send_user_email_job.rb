class SendUserEmailJob < ApplicationJob
  queue_as :default

  def perform(params)
    puts "JOB ASYnc - ===-=-=---------============000================="
    puts "JOB ASYnc - ===-=-=---------============000================="
    puts "JOB ASYnc - ===-=-=---------============000================="
    puts "JOB ASYnc - ===-=-=---------============000================="
    user = User.find(params[:user_id])
    UserMailer.send_order_status_mail(user: user, current_stage: params[:stage], order_id: params[:order_id]).deliver_later
  end
end
