# frozen_string_literal: true
module PartnershipsHelper
  def partner_logo(partner)
    logo = cl_image_tag partner.logo, width: 350, crop: :scale, class: 'photo'
    return logo if partner.external_link.blank?
    link_to(partner.external_link, target: 'blank', rel: 'nofollow', class: 'photo') { logo }
  end
end
