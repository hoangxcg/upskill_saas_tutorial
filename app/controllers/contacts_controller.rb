class ContactsController < ApplicationController
  
  # GET request to /contact-us
  #Show new contact form
  def new
    @contact = Contact.new
  end
  
  #POST request /contacts
  def create
    #Mass assignment of form-fields into Contact object
    @contact = Contact.new(contact_params)
    #Save the Contact object to databse
    if @contact.save
      #Store form fields into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      #Plug variables into Contact Mailer
      #email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      #Store success mess into flash hash
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      #Store error into flash hash and redirect to new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path
    end
  end
  
  #Collect data and secure by strong parameters and whitelist the form fields
  private
    def contact_params
       params.require(:contact).permit(:name, :email, :comments)
    end
end
