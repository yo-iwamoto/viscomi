class Api::V1::ContactsController < ApiController

  def index
    # 後でトークンから判断してソートするよう書き換える
    @contacts = Contact.all
  end

  def create
    community_center = CommunityCenter.find_by!(id: params[:community_center_id])
    @contact = community_center.contacts.build(contact_params)
    response_bad_request unless @contact.save
    render 'create'
  end

  def mail
    contact = Contact.find(params[:id])
    contact.community_center.send_contact(contact)
    @contact = contact.update(sent_at: Time.zone.now)
  end

  def update
  end

  def image
    @contact = Contact.find_by!(id: params[:id])
    @contact.create_contact_image(image: params[:image])
    response_success
  end

  private

    def contact_params
      params.require(:contact).permit(:subject, :content)
    end
end
