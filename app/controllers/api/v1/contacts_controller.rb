class Api::V1::ContactsController < ApiController
  before_action :set_contact, only: %i[show mail update image]

  def index
    # 後でトークンから判断してソートするよう書き換える
    @contacts = Contact.all
  end

  def show
  end

  def create
    community_center = CommunityCenter.find_by!(id: params[:community_center_id])
    @contact = community_center.contacts.build(contact_params)
    response_bad_request unless @contact.save
    render 'create'
  end

  def mail
    @contact.community_center.send_contact(@contact)
    response_bad_request unless @contact.update(sent_at: Time.zone.now)
  end

  def update
    response_bad_request unless @contact.update(contact_params)
    response_success
  end

  def image
    @contact.create_contact_image(image: params[:image])
    response_success
  end

  private

    def contact_params
      params.require(:contact).permit(:subject, :content)
    end

    def set_contact
      @contact = Contact.find_by!(id: params[:id])
      response_bad_request if @contact.nil?
    end
end
