class UserMailer < ApplicationMailer

  default from: Settings.mail_from

  def suggest_mail suggest

    @suggest = suggest

    mail to: Settings.mail_to, subject: t("mail.subject")

  end

end
