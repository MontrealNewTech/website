class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      render js: "$('#email_sign_up_box').html('<p>#{ t('.thanks') }</p>')"
    else
      render 'fail'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email)
  end
end
