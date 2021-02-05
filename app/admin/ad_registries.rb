ActiveAdmin.register AdRegistry do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :ad_id, :community_center_id
  #
  # or
  #
  permit_params do
    permitted = [:ad_id, :community_center_id]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
