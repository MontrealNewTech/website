class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render js: "$('#email_sign_up_box').html('<h3>#{ t('.thanks') }</h3>')"
    else
      render 'fail'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email).merge(remote_ip: request.remote_ip)
  end
end
