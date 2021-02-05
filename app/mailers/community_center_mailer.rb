class CommunityCenterMailer < ApplicationMailer

  def contact(contact, user)
    @community_center_name = contact.community_center.name
    @content = contact.content
    @image_url = contact.image&.file&.file
    @user_name = user.name
    mail to: user.email, subject: contact.subject
  end

end
