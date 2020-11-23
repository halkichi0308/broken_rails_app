class NotificationMailer < ActionMailer::Base
  default from: "YourMailDodamin<xxx@example.com>"

  def send_confirm_to_user(obj)
    mail_obj = obj
    mail_obj[:subject] = "Send Mail"
    mail(mail_obj) do |format|
      format.text
    end
    #mail(
    #  subject: "Send Mail2", #メールのタイトル
    #  #to: "xxx@example.com" #宛先
    #  to: email #宛先
    #) do |format|
    #  format.text
    #end
  end
end