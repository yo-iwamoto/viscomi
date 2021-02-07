class Api::V1::ContactsController < ApiController
  before_action :authenticate_user?, only: %i[index show create update destroy mail image]
  before_action :set_contact, only: %i[show mail update image]

  def index
    community_center = current_user.community_center
    @contacts = community_center.contacts
  end

  def show
  end

  def create
    community_center = current_user.community_center
    @contact = community_center.contacts.build(contact_params)
    response_bad_request unless @contact.save
  end
  
  def update
    response_bad_request unless @contact.update(contact_params)
    response_success
  end

  def destroy
  end

  def mail
    community_center = @contact.community_center
    @contact.update(now_processing: true)
    community_center.send_contact(@contact)
    @contact.update(now_processing: false)
    response_bad_request unless @contact.update(sent_at: Time.zone.now)
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
      community_center = @contact.community_center
      # メールが存在しない場合、あるいは別の公民館のメールにアクセスしようとしている場合、アクセスをはじく
      response_bad_request if @contact.nil? || !correct_community_center?(community_center)
    end
end
