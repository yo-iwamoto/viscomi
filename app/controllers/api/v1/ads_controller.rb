class Api::V1::AdsController < ApiController
  ActionController::Parameters.permit_all_parameters = true
  def create
    ad = Ad.create(ad_params)
    community_centers = params[:community_centers]
    (community_centers.length).times do |n|
      community_center = CommunityCenter.find_by!(name: community_centers[n])
      ad.ad_registries.create(community_center_id: community_center.id)
    end
  end

  def image
    ad = Ad.first
    ad.create_ad_image(image: params[:image])
  end

  private

    def ad_params
      params.require(:ad).permit(:owner_name, :content, :phone_number, :url)
    end
end
